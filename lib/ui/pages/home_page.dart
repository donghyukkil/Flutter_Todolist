import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/utils/dialog_utils.dart';
import 'package:todolist/data/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TaskViewModel taskViewModel = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-do List'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
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
                        taskViewModel.addTaskIfNotEmpty(
                            textEditingController.text, _tabController.index);
                        textEditingController.clear();
                      },
                    )),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Obx(() => _buildTaskList(taskViewModel.tasks
                      .where((task) => task.tab == 0 && !task.isDone)
                      .toList())),
                  Obx(() => _buildTaskList(taskViewModel.tasks
                      .where((task) => task.tab == 1 && task.isDone)
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
    return ReorderableListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          key: ValueKey(task.id),
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              task.title,
              style: task.isDone
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            leading: Checkbox(
              value: task.isDone,
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
                  onPressed: () => DialogUtils.showDeleteConfirmation(
                      context, task.id, taskViewModel),
                ),
              ],
            ),
          ),
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        taskViewModel.reorderTask(oldIndex, newIndex, _tabController.index);
      },
    );
  }
}
