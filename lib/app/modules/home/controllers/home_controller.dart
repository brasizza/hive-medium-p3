import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_tutorial/app/data/models/task_model.dart';
import 'package:hive_tutorial/app/modules/home/controllers/hive_controller.dart';

class HomeController extends GetxController {
  final _todoList = <TaskModel>[].obs;
  get todoList => _todoList;
  final Box<TaskModel> _boxTask = Get.find<Box<TaskModel>>();
  final HiveController hiveController = Get.find<HiveController>();
  @override
  void onInit() async {
    super.onInit();
    _todoList.bindStream(hiveController.bindHive());
    _todoList.addAll(await hiveController.firstData());
  }

  Future<void> addTask({required String title, String? description, String? tag, required bool done}) async {
    int id = DateTime.now().millisecond;
    final _task = TaskModel(id: id, title: title, description: description ?? '', tag: tag ?? '', done: done);
    await _boxTask.add(_task);
  }

  void changeStatus(int index, bool newValue) async {
    final _todo = _todoList[index];
    _todo.done = newValue;
    await _todo.save();
  }

  Future<void> updateTask(TaskModel? todo, {required String title, String? description, String? tag, required bool done}) async {
    int index = _todoList.indexOf(todo!);
    final _todo = _todoList[index];
    _todo.title = title;
    _todo.description = description;
    _todo.tag = tag;
    _todo.done = done;
    await _todo.save();
  }

  Future<void> deleteTask(TaskModel? todo) async {
    int index = _todoList.indexOf(todo!);
    final _todo = _todoList[index];
    await _todo.delete();
  }
}
