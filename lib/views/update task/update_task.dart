import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/controllers/add%20task/add_task_bloc.dart';
import 'package:todo_app/controllers/home%20bloc/home_bloc.dart';
import 'package:todo_app/controllers/services/task%20service/task_service.dart';
import 'package:todo_app/model/task%20model/task_model.dart';
import 'package:todo_app/views/home/home.dart';

class TaskUpdateScreenPage extends StatefulWidget {
  final TaskModel task;
  final int index;

  TaskUpdateScreenPage({required this.task, required this.index});

  @override
  _TaskUpdateScreenPageState createState() => _TaskUpdateScreenPageState();
}

class _TaskUpdateScreenPageState extends State<TaskUpdateScreenPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime selectedDate;
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    selectedDate = widget.task.date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day, 23, 59);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
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
                TaskModel updatedTask = TaskModel(
                  title: title,
                  date: date,
                  description: description,
                  status: widget.task.status,
                );
                taskService.updateTask(widget.index, updatedTask);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false);
              },
              child: Text('Update Task'),
            )
          ],
        ),
      ),
    );
  }
}
