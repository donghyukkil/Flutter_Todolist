import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/utils/dialog_utils.dart';

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
                      taskViewModel
                          .addTaskIfNotEmpty(textEditingController.text);
                      textEditingController.clear();
                    },
                  )),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: taskViewModel.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskViewModel.tasks[index];

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(task.title.value,
                            style: task.isDone.value
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough)
                                : null),
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
                              onPressed: () {
                                DialogUtils.showEditTaskDialog(
                                    context, task, taskViewModel);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                taskViewModel.deleteTask(task.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
