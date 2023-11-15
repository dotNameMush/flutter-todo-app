import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/config/theme.dart';
import 'package:todoapp/data/models/task_models.dart';
import 'package:todoapp/data/repositories/task_repo.dart';
import 'package:todoapp/service/prefs_service.dart';
import 'package:uuid/uuid.dart';

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({super.key});

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Task",
                style: appTheme.textTheme.headlineMedium,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: 'Enter task title', labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateField(
                    date: _date,
                    onDateChanged: (value) {
                      setState(() {
                        _date = value ?? _date;
                      });
                    },
                  ),
                  TimeField(
                    date: _date,
                    onDateChanged: (value) {
                      setState(() {
                        _date = value ?? _date;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SharedPreferencesService().saveData(
                          'tasks2',
                          TaskModel(
                                  id: const Uuid().v8(),
                                  title: _titleController.text,
                                  date: _date)
                              .toJson());
                      await TaskRepository()
                          .createTask(TaskModel(
                              id: const Uuid().v8(),
                              title: _titleController.text,
                              date: _date))
                          .then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(12)),
                  child: const Text("Create"),
                ),
              )
            ],
          ),
        ));
  }
}

class DateField extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime?> onDateChanged;
  const DateField({super.key, required this.date, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final value = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          onDateChanged(value);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, padding: const EdgeInsets.all(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat("yyyy/MMM/dd").format(date)),
            const Icon(Icons.date_range)
          ],
        ),
      ),
    );
  }
}

class TimeField extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime?> onDateChanged;
  const TimeField({super.key, required this.date, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final value = await showTimePicker(
              context: context, initialTime: TimeOfDay.fromDateTime(date));
          if (value != null) {
            onDateChanged(DateTime(
                date.year, date.month, date.day, value.hour, value.minute));
          } else {
            onDateChanged(null);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, padding: const EdgeInsets.all(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat("hh:mm a").format(date)),
            const Icon(Icons.access_time)
          ],
        ),
      ),
    );
  }
}
