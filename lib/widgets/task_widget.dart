import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assignment/providers/app_provider.dart';
import 'package:provider_assignment/models/task_model.dart';

class TaskWidget extends StatefulWidget {

  final Task task;
  TaskWidget(this.task);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  // this method to show dialog for user before delete the task
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () {
        Provider.of<AppProvider>(context, listen: false).deleteTask(widget.task);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Task"),
      content: Text("are you sure you want to delete this task!?"),
      actions: [noButton, yesButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red), 
              onPressed: () {
                //show dialog for user before delete the task
                showAlertDialog(context);
              }
            ),
            Text(widget.task.taskName),
            Checkbox(
              value: widget.task.isCompleted,
              onChanged: (value) {
                widget.task.isCompleted = !widget.task.isCompleted;
                Provider.of<AppProvider>(context, listen: false).updateTask(widget.task);
              }
            ),
          ],
        ),
      ),
    );
  }
}
