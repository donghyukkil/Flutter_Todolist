import 'package:flutter/material.dart';

import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/data/models/task.dart';

class DialogUtils {
  static void showEditTaskDialog(
      BuildContext context, Task task, TaskViewModel taskViewModel) {
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
                child: const Text('Save')),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  static void showDeleteConfirmation(
      BuildContext context, int taskId, TaskViewModel taskViewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Task",
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Are you sure you want to delete this task?",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                taskViewModel.deleteTask(taskId);
                Navigator.of(context).pop();
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
