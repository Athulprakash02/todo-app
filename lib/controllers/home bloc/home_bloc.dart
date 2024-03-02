import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/controllers/services/task%20service/task_service.dart';
import 'package:todo_app/model/task%20model/task_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(taskList: tasksList)) {
    on<HomeInitialEvent>((event, emit) {
      final taskDb = Hive.box<TaskModel>('tasks');
      tasksList.addAll(taskDb.values);
      return emit(HomeLoadedState(taskList: tasksList));
    });
    on<DeleteTaskEvent>((event, emit) {
      tasksList.removeAt(event.taskId);
      return emit(HomeLoadedState(taskList: tasksList));
    });
  }
}
