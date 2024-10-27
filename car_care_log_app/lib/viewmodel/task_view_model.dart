import 'package:flutter/material.dart';
import '../model/car_model.dart';
import '../services/database_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  TaskModel? task;
  List<StepModel> steps = [];
  int currentStepNumber = 1;

  // Load task details and its steps
  Future<void> loadTask(int taskId) async {
    task = await _databaseService.getTaskById(taskId);
    steps = await _databaseService.getStepsForTask(taskId);
    currentStepNumber = steps.length + 1;
    notifyListeners();
  }

  // Add a new step to the task
  Future<void> addStep(int taskId, String description) async {
    final newStep = StepModel(
      taskId: taskId,
      stepNumber: currentStepNumber,
      description: description,
      completed: false,
    );

    await _databaseService.insertStep(newStep, taskId);
    steps.add(newStep);
    currentStepNumber++;
    notifyListeners();
  }

  // Get the next step number for a task
  int getNextStepNumber(int taskId) {
    return steps.isNotEmpty ? steps.length + 1 : 1;
  }

  // Update a step's completion status
  Future<void> updateStepCompletion(int stepId, bool completed) async {
    await _databaseService.updateStepCompletion(stepId, completed);
    final stepIndex = steps.indexWhere((step) => step.id == stepId);
    if (stepIndex != -1) {
      steps[stepIndex] = steps[stepIndex].copyWith(completed: completed);
      await _updateTaskStatus();
      notifyListeners();
    }
  }

  // Update task status based on step completion
  Future<void> _updateTaskStatus() async {
    if (steps.every((step) => step.completed)) {
      task?.status = 'completed';
    } else if (steps.any((step) => step.completed)) {
      task?.status = 'in_progress';
    } else {
      task?.status = 'not_started';
    }

    if (task?.id != null) {
      await _databaseService.updateTaskStatus(task!.id!, task!.status);
    }
  }

  // Complete the task
  Future<void> completeTask() async {
    task?.status = 'completed';
    if (task?.id != null) {
      await _databaseService.updateTaskStatus(task!.id!, 'completed');
      notifyListeners();
    }
  }

  Future<TaskModel> getTaskById(int taskId) async {
    return await _databaseService.getTaskById(taskId);
  }

  Future<List<StepModel>> getStepsByTaskId(int taskId) async {
    return await _databaseService.getStepsForTask(taskId);
  }
}
