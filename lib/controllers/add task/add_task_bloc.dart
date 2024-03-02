import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/controllers/services/task%20service/task_service.dart';
import 'package:todo_app/model/task%20model/task_model.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    on<TaskAddButtonClicked>((event, emit) {
      tasksList.add(event.taskDetails);
    });
  }
}
