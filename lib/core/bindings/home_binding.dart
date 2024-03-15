import 'package:get/get.dart';

import 'package:todolist/core/viewmodels/task_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskViewModel>(() => TaskViewModel());
  }
}
