import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/core/bindings/home_binding.dart';
import 'package:todolist/ui/pages/home_page.dart';
import 'package:todolist/core/viewmodels/task_viewmodel.dart';

void main() {
  runApp(const MyApp());
  Get.put(TaskViewModel());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do list App',
      initialBinding: HomeBinding(),
      home: HomePage(),
    );
  }
}
