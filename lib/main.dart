import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/app/data/models/task_model.dart';

import 'app/routes/app_pages.dart';

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Box<TaskModel> _taskBox = await Hive.openBox<TaskModel>('tasks');
  Get.put<Box<TaskModel>>(
    _taskBox,
    permanent: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
