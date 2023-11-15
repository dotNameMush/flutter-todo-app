import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todoapp/data/models/task_models.dart';
import 'package:todoapp/data/repositories/task_repo.dart';
import 'package:todoapp/presentation/pages/home.dart';
import 'package:todoapp/presentation/widgets/appbar.dart';
import 'package:todoapp/presentation/widgets/create_task_sheet.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  bool isLoading = false;
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  _fetchTasks() async {
    log("Fetching new tasks");
    setState(() {
      isLoading = true;
    });
    var res = await TaskRepository().getAllTasks();

    tasks = res.values.toList();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TodoAppBar(),
      body: HomePage(
        onRefresh: () => _fetchTasks(),
        tasks: tasks,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const CreateTaskSheet();
            },
          ).then((value) => _fetchTasks());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
