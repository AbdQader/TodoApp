import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assignment/providers/app_provider.dart';
import 'package:provider_assignment/models/task_model.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  String taskName;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 100, 30, 30),
        child: Column(
          children: [
            TextField(
                onChanged: (value) => taskName = value,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)
                  ),
                ),
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.text,
            ),
            SizedBox(height: 30),
            Checkbox(
              value: this.isCompleted, 
              onChanged: (value) {
                this.isCompleted = !this.isCompleted;
                setState(() {});
              }
            ),
            SizedBox(height: 30),
            Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false).insertTask(Task(this.taskName, this.isCompleted));
                    Navigator.pop(context);
                  },
                  child: Text('Add Task', style: TextStyle(fontSize: 24),),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(15),
                ),
            ),  
          ],
        ),
      ),
    );
  }
}
