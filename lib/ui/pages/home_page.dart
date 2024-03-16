import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/utils/dialog_utils.dart';
import 'package:todolist/data/models/task.dart';

class HomePage extends StatelessWidget {
  final TaskViewModel taskViewModel = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-do List'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'In Progress'),
              Tab(icon: Icon(Icons.done_all), text: 'Completed'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    labelText: 'Enter your task',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        taskViewModel
                            .addTaskIfNotEmpty(textEditingController.text);
                        textEditingController.clear();
                      },
                    )),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => _buildTaskList(taskViewModel.tasks
                      .where((task) => !task.isDone.value)
                      .toList())),
                  Obx(() => _buildTaskList(taskViewModel.tasks
                      .where((task) => task.isDone.value)
                      .toList())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              task.title.value,
              style: task.isDone.value
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            leading: Checkbox(
              value: task.isDone.value,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  taskViewModel.toggleTaskStatus(task.id);
                }
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => DialogUtils.showEditTaskDialog(
                      context, task, taskViewModel),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => taskViewModel.deleteTask(task.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
