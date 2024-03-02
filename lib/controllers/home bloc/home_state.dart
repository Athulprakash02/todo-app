part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<TaskModel> taskList;

  HomeState({required this.taskList});
}

final class HomeInitial extends HomeState {
  HomeInitial({required super.taskList});
}

class HomeLoadedState extends HomeState {
  HomeLoadedState({required super.taskList});
  
}
