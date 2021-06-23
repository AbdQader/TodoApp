import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:provider_assignment/models/task_model.dart';

class DBHelper {

  // Private Constructor
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  
  // Define the database, tables, and columns names
  static String databaseName = 'tasksDb.db';
  static String tableName = 'tasks';
  static String taskIdColumnName = 'id';
  static String taskNameColumnName = 'name';
  static String taskIsCompleteColumnName = 'isComplete';

  // Object from database
  Database database;

  // Initialize the database
  Future<Database> initDatabase() async {
    if (database == null)
    {
      return await createDatabase();
    } else {
      return database;
    }
  }

  // Create the database
  Future<Database> createDatabase() async {
    try {
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName); // OR => String path = databasesPath + '/demo.db';
      Database database = await openDatabase(path, version: 1, onCreate: _onCreate,);
      return database;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  // Create the database and the tables
  void _onCreate(db, version) {
    db.execute('''CREATE TABLE $tableName(
      $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $taskNameColumnName TEXT NOT NULL,
      $taskIsCompleteColumnName INTEGER
    )''');
  }

  // Get all tasks from the database
  Future<List<Task>> getTasks() async {
    try {
      database = await initDatabase();
      // this will return the tasks as a "Map"
      List<Map> result = await database.query(tableName);
      List<Task> taskList = <Task>[];
      result.forEach((task) {
        // convert the "Map" to "Task" and add the task to "taskList"
        taskList.add(Task.fromMap(task));
      });
      return taskList;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  // Insert new task in the database
  insertTask(Task task) async {
    try {
      database = await initDatabase();
      await database.insert(tableName, task.toJson());
    } on Exception catch (e) {
      print(e);
    }
  }

  // Updata task in the database
  updateTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.update(tableName, task.toJson(), where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  // Delete task from the database
  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.delete(tableName, where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  /*
  // Get all tasks in the database as a "Map"
  Future<List<Map>> getAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      return result;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  // Get the 'Map List' and convert it to 'Task List'
  Future<List<Task>> getTaskList() async {
    var taskMapList = await getAllTasks(); // Get 'Map List' from database
    int count = taskMapList.length;        // Count the number of map entries in db table
    List<Task> taskList = <Task>[];
    // For loop to create a 'task List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMap(taskMapList[i]));
    }
    return taskList;
  }
  */

}