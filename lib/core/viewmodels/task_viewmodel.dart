import 'package:get/get.dart';

import 'package:todolist/data/models/task.dart';

class TaskViewModel extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(Task task) {
    tasks.add(task);
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
    tasks.firstWhere((task) => task.id == id).toggleDone();
    tasks.refresh();
  }
}
