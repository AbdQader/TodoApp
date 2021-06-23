import 'package:flutter/cupertino.dart';
import 'package:provider_assignment/database/db_helper.dart';
import 'package:provider_assignment/models/task_model.dart';

class AppProvider extends ChangeNotifier {

  Future<List<Task>> getTasks() async {
    return await DBHelper.dbHelper.getTasks();
  }

  void insertTask(Task task) {
    DBHelper.dbHelper.insertTask(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    DBHelper.dbHelper.deleteTask(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    DBHelper.dbHelper.updateTask(task);
    notifyListeners();
  }

}
