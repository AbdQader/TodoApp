import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assignment/providers/app_provider.dart';
import 'package:provider_assignment/models/task_model.dart';
import 'package:provider_assignment/widgets/task_widget.dart';

class UncompletedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<AppProvider>(context, listen: true).getTasks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData 
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // to reverse the tasks list
                  List<Task> tasks = snapshot.data.reversed.toList();
                  Task task = tasks[index];
                  // to check if the task is completed or not
                  if (!task.isCompleted)
                    return TaskWidget(task);
                  else
                    return Container();
                },
            );
        },
      ),
      // child: ListView.builder(
      //   scrollDirection: Axis.vertical,
      //   itemCount: Provider.of<AppProvider>(context, listen: false).getTasks().length,
      //   itemBuilder: (context, index) {
      //     Task task = Provider.of<AppProvider>(context, listen: false).getTasks()[index];
      //     // to check if the task is completed or not
      //     if (!task.isCompleted)
      //       return TaskWidget(task);
      //     else
      //       return Container();
      //   },
      // ),
    );
  }
}
