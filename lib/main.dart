import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todolist/core/bindings/home_binding.dart';
import 'package:todolist/ui/pages/home_page.dart';
import 'package:todolist/core/viewmodels/task_viewmodel.dart';
import 'package:todolist/data/models/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
