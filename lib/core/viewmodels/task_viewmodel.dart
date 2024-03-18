import 'dart:math';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/models/task.dart';
import 'package:todolist/utils/dialog_utils.dart';

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
    final box = await _openBox();
    final orderedTasks = box.values.toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    tasks.assignAll(orderedTasks);
  }

  Future<Box<Task>> _openBox() async {
    return await Hive.openBox<Task>('tasks');
  }

  int _getMaxValue(List<int> values, int fallback) {
    return values.isEmpty ? fallback : values.reduce(max) + 1;
  }

  void addTaskIfNotEmpty(String title, int tab) async {
    if (title.isNotEmpty) {
      final box = await _openBox();
      final int newId = _getMaxValue(tasks.map((task) => task.id).toList(), 0);
      final int newOrder =
          _getMaxValue(tasks.map((task) => task.order).toList(), 0);

      final task = Task(
        id: newId,
        title: title,
        isDone: false,
        order: newOrder,
        tab: tab,
      );

      await box.add(task);
      tasks.add(task);
    } else {
      DialogUtils.showSnackbar("Task title cannot be empty.", isError: true);
    }
  }

  void editTask(int id, String newTitle) async {
    final box = await _openBox();
    final Task task = box.values.firstWhere((t) => t.id == id);
    task.title = newTitle;
    task.save();
    tasks.refresh();
  }

  void deleteTask(int id) async {
    final box = await _openBox();
    final taskKey = box.keys.firstWhere(
      (key) => box.get(key)?.id == id,
      orElse: () => null,
    );

    if (taskKey != null) {
      await box.delete(taskKey);
      tasks.removeWhere((task) => task.id == id);
      DialogUtils.showSnackbar("Task has been deleted successfully.");
    }
  }

  void toggleTaskStatus(int id) async {
    final box = await _openBox();
    final Task task = box.values.firstWhere(
      (t) => t.id == id,
    );
    task.isDone = !task.isDone;
    task.tab = task.isDone ? 1 : 0;
    await task.save();
    DialogUtils.showSnackbar("Task status updated", isError: false);
    tasks.refresh();
  }

  void reorderTask(int oldIndex, int newIndex, int tab) async {
    List<Task> currentTabTasks =
        tasks.where((task) => task.tab == tab).toList();
    List<Task> otherTabTasks = tasks.where((task) => task.tab != tab).toList();

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    Task movedTask = currentTabTasks.removeAt(oldIndex);
    currentTabTasks.insert(newIndex, movedTask);

    for (int i = 0; i < currentTabTasks.length; i++) {
      currentTabTasks[i].order = i;
    }

    try {
      await Future.wait(currentTabTasks.map((task) => task.save()).toList());
    } catch (e) {
      DialogUtils.showSnackbar("Error saving tasks: $e", isError: true);

      return;
    }

    tasks.assignAll([...currentTabTasks, ...otherTabTasks]);
    tasks.sort((a, b) => a.order.compareTo(b.order));
    tasks.refresh();
  }
}
