import 'package:json_annotation/json_annotation.dart';

part 'task_models.g.dart';

@JsonSerializable()
class TaskModel {
  final String id;
  final String title;
  bool isCompleted;
  final DateTime date;
  TaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.date,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
