import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_tutorial/app/data/models/task_model.dart';
import 'package:hive_tutorial/app/modules/home/controllers/dialog_controller.dart';
import 'package:hive_tutorial/app/modules/home/controllers/hive_controller.dart';
import 'package:hive_tutorial/app/modules/home/views/components/dialog_todo_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx + Hive w/ bindstream'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: Visibility(
                visible: controller.todoList!.length > 0,
                replacement: const Center(child: Text('There is no tasks for you!')),
                child: ListView.separated(
                  itemCount: controller.todoList!.length,
                  itemBuilder: (_, index) {
                    final TaskModel _todo = controller.todoList[index];
                    return ListTile(
                      onTap: () {
                        Get.lazyPut<DialogController>(() => DialogController());
                        Get.find<DialogController>().todoCheck.value = _todo.done;
                        Get.dialog(Dialog(
                          child: DialogTodo(todo: _todo),
                        ));
                      },
                      title: Text(_todo.title),
                      subtitle: Text(_todo.description ?? ''),
                      leading: Checkbox(
                          value: _todo.done,
                          onChanged: (newValue) {
                            controller.changeStatus(index, newValue!);
                          }),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ),
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.lazyPut<DialogController>(() => DialogController());
                  Get.dialog(Dialog(
                    child: DialogTodo(),
                  ));
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Get.find<HiveController>().deleteAll();
                },
                child: const Icon(
                  Icons.delete_forever,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
