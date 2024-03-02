part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskEvent {}

class TaskAddButtonClicked extends AddTaskEvent{
  final TaskModel taskDetails;

  TaskAddButtonClicked({required this.taskDetails});
}
