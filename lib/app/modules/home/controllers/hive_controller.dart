import 'dart:async';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/app/data/models/task_model.dart';

class HiveController extends GetxController {
  final Box<TaskModel> _boxTask = Get.find<Box<TaskModel>>();
  StreamController<List<TaskModel>> controller = StreamController<List<TaskModel>>();

  Stream<List<TaskModel>> bindHive() {
    return _boxTask.watch().map((event) => _boxTask.values.toList());
  }

  Future<List<TaskModel>> firstData() async => _boxTask.values.toList();

  Future<void> deleteAll() async {
    await _boxTask.clear();
  }
}
