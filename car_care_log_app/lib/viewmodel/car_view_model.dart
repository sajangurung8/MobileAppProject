// lib/view_models/car_view_model.dart
import 'package:car_care_log_app/model/car.dart';
import 'package:car_care_log_app/model/task.dart';
import 'package:flutter/material.dart';
import '../services/database_service.dart';

class CarViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<CarModel> cars = [];

  Future<void> loadCars() async {
    cars = await _databaseService.getCars();
    notifyListeners();
  }

  Future<void> addCar(CarModel car) async {
    await _databaseService.insertCar(car);
    await loadCars();
  }

  Future<void> updateCar(CarModel car) async {
    await _databaseService.updateCar(car);
    await loadCars();
  }

  Future<void> deleteCar(int id) async {
    await _databaseService.deleteCar(id);
    await loadCars();
  }

  CarModel? getCarById(int carId) {
    return cars.firstWhere((car) => car.id == carId);
  }

  Future<void> addTask(TaskModel task) async {
    await _databaseService.insertTask(task);
    notifyListeners(); // Notify listeners if you want to update UI
  }

  Future<List<TaskModel>> getTasksByCarId(int carId) async {
    return await _databaseService.getTasksByCarId(carId);
  }

  // Update task status
  Future<void> updateTaskStatus(int taskId, String newStatus) async {
    await _databaseService.updateTaskStatus(taskId, newStatus);
    final task = await _databaseService.getTaskById(taskId);
    await _updateCarStatus(task.carId);
    notifyListeners();
  }

  // Update the status of a car based on its tasks
  Future<void> _updateCarStatus(int carId) async {
    final tasks = await _databaseService.getTasksByCarId(carId);

    if (tasks.isEmpty) {
      await _databaseService.updateCarStatus(carId, 'no_maintenance_needed');
      return;
    }

    bool hasDueTask = tasks.any((task) => task.status == 'due');
    bool hasInProgressTask = tasks.any((task) => task.status == 'in_progress');

    String newStatus;
    if (hasDueTask) {
      newStatus = 'due'; // red
    } else if (hasInProgressTask) {
      newStatus = 'in_progress'; // amber
    } else {
      newStatus = 'no_maintenance_needed'; // green
    }

    await _databaseService.updateCarStatus(carId, newStatus);
  }
}
