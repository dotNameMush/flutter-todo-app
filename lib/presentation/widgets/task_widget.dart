import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/config/theme.dart';
import 'package:todoapp/data/models/task_models.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onChanged;
  const TaskWidget({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: task.isCompleted, onChanged: onChanged),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: appTheme.textTheme.bodyMedium),
            Text(DateFormat("hh:mm a").format(task.date),
                style: appTheme.textTheme.bodySmall),
          ],
        )
      ],
    );
  }
}
