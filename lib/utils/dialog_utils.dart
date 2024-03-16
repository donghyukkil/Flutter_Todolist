import 'package:flutter/material.dart';

import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/data/models/task.dart';

class DialogUtils {
  static void showEditTaskDialog(
      BuildContext context, Task task, TaskViewModel taskViewModel) {
    TextEditingController editTextController =
        TextEditingController(text: task.title.value);

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
                child: const Text('Save')),
          ],
        );
      },
    );
  }
}
