import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/controllers/home%20bloc/home_bloc.dart';
import 'package:todo_app/model/task%20model/task_model.dart';

List<TaskModel> tasksList = [];

class TaskService {
  getTasks() {
    final taskDb = Hive.box<TaskModel>('tasks');
    tasksList.clear();
    tasksList.addAll(taskDb.values);
  }

  deleteAlarm(int id, BuildContext context) {
    final taskDb = Hive.box<TaskModel>('tasks');
    BlocProvider.of<HomeBloc>(context).add(DeleteTaskEvent(taskId: id));
    getTasks();
  }

  updateTask(int id, TaskModel taskDetails) {
    final tasksDb = Hive.box<TaskModel>('tasks');
    tasksDb.putAt(id, taskDetails);
  }
}
