import 'package:car_care_log_app/model/step.dart';
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../services/database_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  TaskModel? task;
  List<StepModel> steps = [];
  int currentStepNumber = 1;

  // Load task details and its steps
  Future<void> loadTask(int taskId) async {
    task = await _databaseService.getTaskById(taskId);
    currentStepNumber = 1;
    steps = await _databaseService.getStepsForTask(taskId);
    notifyListeners();
  }

  // Add a new step to the task
  Future<void> addStep(int taskId, String description) async {
    final newStep = StepModel(
      taskId: taskId,
      stepNumber: await getNextStepNumber(taskId),
      description: description,
    );

    await _databaseService.insertStep(newStep, taskId);
    steps.add(newStep);
    loadTask(taskId);
  }

  // Get the next step number for a task
  Future<int> getNextStepNumber(taskId) async {
    var stepsForTask = await _databaseService.getStepsForTask(taskId);
    return stepsForTask.isNotEmpty ? steps.length + 1 : 1;
  }

  Future<TaskModel> getTaskById(int taskId) async {
    return await _databaseService.getTaskById(taskId);
  }

  Future<List<StepModel>> getStepsByTaskId(int taskId) async {
    return await _databaseService.getStepsForTask(taskId);
  }
}
