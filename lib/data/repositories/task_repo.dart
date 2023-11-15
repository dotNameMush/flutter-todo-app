import 'package:todoapp/data/models/task_models.dart';
import 'package:todoapp/service/prefs_service.dart';

class TaskRepository {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  // Create a new task
  Future<void> createTask(TaskModel task) async {
    var tasks = await getAllTasks();

    tasks.addAll({task.id: task});
    final json = tasks.map((key, value) => MapEntry(key, value.toJson()));
    print(json);
    await _sharedPreferencesService.saveData('tasks', json);
  }

  // Update a task by its ID
  Future<void> updateTaskById(TaskModel updatedTask) async {
    final tasks = await getAllTasks();
    if (tasks.containsKey(updatedTask.id)) {
      tasks[updatedTask.id] = updatedTask;
      await _sharedPreferencesService.saveData('tasks', tasks);
    }
  }

  // Get a task by its ID
  Future<TaskModel?> getTaskById(String taskId) async {
    final tasks = await getAllTasks();
    if (tasks.containsKey(taskId)) {
      return TaskModel.fromJson(tasks[taskId]!.toJson());
    }
    return null;
  }

  // Get all tasks
  Future<Map<String, TaskModel>> getAllTasks() async {
    final tasksJson = await _sharedPreferencesService.getData('tasks');
    if (tasksJson != null) {
      final tasksMap = Map<String, dynamic>.from(tasksJson);
      return tasksMap.map((key, value) =>
          MapEntry(key, TaskModel.fromJson(value as Map<String, dynamic>)));
    }
    return {};
  }

  // Delete a task by its ID
  Future<void> deleteTaskById(String taskId) async {
    final tasks = await getAllTasks();
    if (tasks.containsKey(taskId)) {
      tasks.remove(taskId);
      await _sharedPreferencesService.saveData('tasks', tasks);
    }
  }
}
