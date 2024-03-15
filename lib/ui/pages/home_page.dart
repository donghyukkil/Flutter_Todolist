import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/data/models/task.dart';

class HomePage extends StatelessWidget {
  final TaskViewModel taskViewModel = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List'),
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
                        if (textEditingController.text.isNotEmpty) {
                          taskViewModel.addTask(
                            Task(
                                id: DateTime.now().millisecondsSinceEpoch,
                                title: textEditingController.text),
                          );
                          textEditingController.clear();
                        }
                      })),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: taskViewModel.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskViewModel.tasks[index];
                    return ListTile(
                      title: Text(task.title,
                          style: task.isDone
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough)
                              : null),
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (newValue) {
                          taskViewModel.toggleTaskStatus(task.id);
                        },
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editTaskTitleDialog(context, task);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            taskViewModel.deleteTask(task.id);
                          },
                        ),
                      ]),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }

  void _editTaskTitleDialog(BuildContext context, Task task) {
    TextEditingController editTextController =
        TextEditingController(text: task.title);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Edit Task')),
            content: TextField(
              controller: editTextController,
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (editTextController.text.isNotEmpty) {
                      taskViewModel.editTask(task.id, editTextController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'))
            ],
          );
        });
  }
}
