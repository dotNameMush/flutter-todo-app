import 'package:flutter/material.dart';
import 'package:todoapp/config/theme.dart';
import 'package:todoapp/data/models/task_models.dart';
import 'package:todoapp/data/repositories/task_repo.dart';
import 'package:todoapp/presentation/widgets/task_widget.dart';

class HomePage extends StatefulWidget {
  final List<TaskModel> tasks;
  final Function() onRefresh;
  const HomePage({super.key, required this.tasks, required this.onRefresh});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hideCompleted = false;
  final today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 59);
  final tomorrow = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().add(const Duration(days: 1)).day, 23, 59, 59);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Today',
                  style: appTheme.textTheme.headlineLarge,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _hideCompleted = !_hideCompleted;
                        });
                      },
                      child: Text(
                        _hideCompleted ? 'Show All' : 'Hide Completed',
                        style: appTheme.textTheme.bodySmall!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          widget.onRefresh();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                )
              ],
            ),
            // Tasks here
            ...widget.tasks
                .where((element) => element.date.isBefore(today))
                .map((e) {
              if (_hideCompleted && e.isCompleted) {
                return const SizedBox();
              }
              return TaskWidget(
                task: e,
                onChanged: (value) {
                  setState(() {
                    e.isCompleted = value!;
                  });
                  TaskRepository().updateTaskById(e);
                },
              );
            }),
            Text(
              'Tomorrow',
              style: appTheme.textTheme.headlineLarge,
            ),
            // Tasks here
            ...widget.tasks
                .where((element) =>
                    element.date.isBefore(tomorrow) &&
                    element.date.isAfter(today))
                .map((e) {
              if (_hideCompleted && e.isCompleted) {
                return const SizedBox();
              } else {
                return TaskWidget(
                  task: e,
                  onChanged: (value) {
                    setState(() {
                      e.isCompleted = value!;
                    });
                    TaskRepository().updateTaskById(e);
                  },
                );
              }
            }),
            Text(
              'Later',
              style: appTheme.textTheme.headlineLarge,
            ),
            // Tasks here
            ...widget.tasks
                .where((element) => element.date.isAfter(tomorrow))
                .map((e) {
              if (_hideCompleted && e.isCompleted) {
                return const SizedBox();
              } else {
                return TaskWidget(
                  task: e,
                  onChanged: (value) {
                    setState(() {
                      e.isCompleted = value!;
                    });
                    TaskRepository().updateTaskById(e);
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
