import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/data/models/task.dart';

class TaskViewModel extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(Task task) {
    tasks.add(task);
  }

  void addTaskIfNotEmpty(String title) {
    if (title.isNotEmpty) {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
      );
      addTask(task);
      Get.snackbar("Success", "Task added successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Task title cannot be empty.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void editTask(int id, String newTitle) {
    Task task = tasks.firstWhere((task) => task.id == id);
    task.title = newTitle;
    tasks.refresh();
  }

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
  }

  void toggleTaskStatus(int id) {
    Task task = tasks.firstWhere((task) => task.id == id);
    task.toggleDone();
    tasks.refresh();
  }
}
