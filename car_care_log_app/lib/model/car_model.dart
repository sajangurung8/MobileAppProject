// lib/models/car_model.dart
class CarModel {
  final int? id;
  final String name;
  final String status;
  final int currentMileage;

  CarModel({
    this.id,
    required this.name,
    required this.status,
    required this.currentMileage,
  });

  // Factory method to create a CarModel from a database map
  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      currentMileage: map['currentMileage'] as int,
    );
  }

  // Method to convert CarModel to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'currentMileage': currentMileage,
    };
  }
}

class TaskModel {
  final int? id;
  final int carId;
  final String taskName;
  final String description;
  final String toolsNeeded;
  String status;

  TaskModel({
    this.id,
    required this.carId,
    required this.taskName,
    required this.description,
    required this.toolsNeeded,
    required this.status,
  });

  // Factory method to create TaskModel from a database map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] as String,
      description: map['description'] as String,
      toolsNeeded: map['toolsNeeded'] as String,
      status: map['status'] as String, 
      carId: map['carId'],
      id: map['id']
    );
  }

  // Method to convert TaskModel to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'description': description,
      'toolsNeeded': toolsNeeded,
      'status': status,
      'carId': carId
    };
  }
}

class StepModel {
  final int? id;
  final int taskId;
  final int stepNumber;
  final String description;
  bool completed;

  StepModel({
    this.id,
    required this.taskId,
    required this.stepNumber,
    required this.description,
    this.completed = false,
  });

  // Factory method to create StepModel from a database map
  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      id: map['id'] as int?,
      taskId: map['taskId'] as int,
      stepNumber: map['stepNumber'] as int,
      description: map['description'] as String,
      completed: (map['completed'] as int) == 1, // assuming 'completed' is stored as 0 or 1 in the database
    );
  }

  // Method to convert StepModel to a map for database insertion
  Map<String, dynamic> toMap(int taskId) {
    return {
      'id': id,
      'taskId': taskId,
      'stepNumber': stepNumber,
      'description': description,
      'completed': completed ? 1 : 0, // storing as 0 or 1
    };
  }

  // copyWith method for creating a copy with updated values
  StepModel copyWith({
    int? id,
    int? taskId,
    int? stepNumber,
    String? description,
    bool? completed,
  }) {
    return StepModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      stepNumber: stepNumber ?? this.stepNumber,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
