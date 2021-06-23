import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assignment/database/db_helper.dart';
import 'package:provider_assignment/providers/app_provider.dart';
import 'package:provider_assignment/models/task_model.dart';
import 'package:provider_assignment/widgets/task_widget.dart';

class AllTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<AppProvider>(context, listen: true).getTasks(),
        builder: (context, snapshot) {
          return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Task task = snapshot.data.reversed.toList()[index];
                  return TaskWidget(task);
                },
            );
        },
      ),
    );
  }
}
