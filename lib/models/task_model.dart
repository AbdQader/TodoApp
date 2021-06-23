
import 'package:provider_assignment/database/db_helper.dart';

class Task {
  
  String taskName;
  bool isCompleted;

  Task(this.taskName, this.isCompleted);

  // Convert the Task to json
  toJson() {
    return {
      DBHelper.taskNameColumnName : this.taskName,
      DBHelper.taskIsCompleteColumnName : this.isCompleted ? 1 : 0,
    };
  }

  // Convert the Map to Task
  Task.fromMap(Map<String, dynamic> map) {
    this.taskName = map['name'];
    if (map['isComplete'] == 1)
      this.isCompleted = true;
    else
      this.isCompleted = false;
  }

}
