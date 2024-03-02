import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/controllers/add%20task/add_task_bloc.dart';
import 'package:todo_app/model/task%20model/task_model.dart';

class TaskAddScreenPage extends StatefulWidget {
  @override
  _TaskAddScreenPageState createState() => _TaskAddScreenPageState();
}

class _TaskAddScreenPageState extends State<TaskAddScreenPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  SizedBox(width: 10),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  String title = _titleController.text;
                  String description = _descriptionController.text;
                  DateTime date = selectedDate;
                  TaskModel taskDetails = TaskModel(
                      title: title,
                      date: date,
                      description: description,
                      status: false);
                  BlocProvider.of<AddTaskBloc>(context)
                      .add(TaskAddButtonClicked(taskDetails: taskDetails));
                },
                child: Text('Add task'))
          ],
        ),
      ),
    );
  }
}
