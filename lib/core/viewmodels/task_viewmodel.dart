import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:todolist/data/models/task.dart';

class TaskViewModel extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

  Future<void> _loadTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    tasks.assignAll(box.values);
  }

  int _getNewId() {
    if (tasks.isEmpty) {
      return 1;
    } else {
      final maxIdTask = tasks.reduce(
          (currentMax, task) => currentMax.id > task.id ? currentMax : task);

      return maxIdTask.id + 1;
    }
  }

  void addTask(Task task) async {
    final box = await Hive.openBox<Task>('tasks');
    await box.add(task);
    tasks.add(task);
  }

  void addTaskIfNotEmpty(String title, int tab) async {
    if (title.isNotEmpty) {
      final int newId = _getNewId();
      final int order = tasks.length;
      final task = Task(
        id: newId,
        title: title,
        isDone: false,
        order: order,
        tab: tab,
      );

      final box = await Hive.openBox<Task>('tasks');
      await box.add(task);
      tasks.add(task);
      tasks.sort((a, b) => a.id.compareTo(b.id));
    } else {
      Get.snackbar("Error", "Task title cannot be empty.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void editTask(int id, String newTitle) async {
    final box = await Hive.openBox<Task>('tasks');
    final Task task = box.values.firstWhere((t) => t.id == id);
    task.title = newTitle;
    task.save();
    tasks.refresh();
  }

  void deleteTask(int id) async {
    final box = await Hive.openBox<Task>('tasks');
    final taskKey = box.keys.firstWhere(
      (key) => box.get(key)?.id == id,
      orElse: () => null,
    );

    if (taskKey != null) {
      await box.delete(taskKey);
      tasks.removeWhere((task) => task.id == id);

      Get.snackbar("Deleted", "Task has been deleted successfully.",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  void toggleTaskStatus(int id) async {
    final box = await Hive.openBox<Task>('tasks');
    final Task task = box.values.firstWhere(
      (t) => t.id == id,
    );
    task.isDone = !task.isDone;
    task.tab = task.isDone ? 1 : 0;
    task.save();
    tasks.refresh();
  }

  void reorderTask(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Task task = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, task);

    for (int i = 0; i < tasks.length; i++) {
      tasks[i].order = i;
      await tasks[i].save();
    }

    tasks.refresh();
  }

  void reloadTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    tasks.assignAll(box.values.toList());
    tasks.sort((a, b) => a.order.compareTo(b.order));
    tasks.refresh();
  }
}
