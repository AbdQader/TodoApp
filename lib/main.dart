import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assignment/screens/all_tasks.dart';
import 'package:provider_assignment/providers/app_provider.dart';
import 'package:provider_assignment/screens/completed_tasks.dart';
import 'package:provider_assignment/screens/new_task.dart';
import 'package:provider_assignment/screens/uncompleted_tasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { 
        return AppProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Todo App'),
        // tab bar
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'All Tasks'),
            Tab(text: 'Completed Tasks'),
            Tab(text: 'Uncompleted Tasks'),
          ],
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AllTasks(),
          CompletedTasks(),
          UncompletedTasks(),
        ],
      ),
      // drawer side
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => NewTask(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
