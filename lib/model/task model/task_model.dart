import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final bool status;

  TaskModel(
      {required this.title,
      required this.date,
      required this.description,
      required this.status});
}
