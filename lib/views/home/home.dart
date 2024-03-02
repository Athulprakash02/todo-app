import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/controllers/home%20bloc/home_bloc.dart';
import 'package:todo_app/controllers/services/task%20service/task_service.dart';
import 'package:todo_app/model/task%20model/task_model.dart';
import 'package:todo_app/views/add%20task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
      final TaskService taskService = TaskService();


  @override
  Widget build(BuildContext context) {
        taskService.getTasks();

    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: SafeArea(
              child:SizedBox(
              width: size.width,
              height: size.height,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: state.taskList.length,
                  itemBuilder: (context, index) {
                    TaskModel task = state.taskList[index];
                    return ListTile(
                      
                      title: Text(task.title),
                      subtitle: Text(task.date.day.toString()),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                             
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) =>
                                //       larm: alarm,index: index,),
                                // ));
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.blue),
                          IconButton(
                            onPressed: () {
                              deleteAlert(context, index);
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  }),
            ),),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TaskAddScreenPage(),
              ));
            },
          ),
        );
      },
    );
  }

   deleteAlert(BuildContext context, key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Delete data Permanently?'),
        actions: [
          TextButton(
              onPressed: () {
                taskService.deleteAlarm(key, context);
                

                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ctx);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }
}
