class TaskModel {
  final int? id;
  final int carId;
  final String taskName;
  final String description;
  final String toolsNeeded;
  String? status;
  int? verifiedManualId;
  bool userCreated;
  int currentStepNumber = 0;
  DateTime? completedDate;
  int? completedMileage;
  String? refrenceUrl;

  TaskModel({
    this.id,
    required this.carId,
    required this.taskName,
    required this.description,
    required this.toolsNeeded,
    this.status,
    required this.userCreated,
    this.refrenceUrl,
    this.currentStepNumber = 0,
  });

  // Factory method to create TaskModel from a database map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] as String,
      description: map['description'] as String,
      toolsNeeded: map['toolsNeeded'] as String,
      carId: map['carId'],
      id: map['id'],
      userCreated: map['userCreated'] as int == 1,
      currentStepNumber: map['currentStepNumber'],
      refrenceUrl: map['refrenceUrl']
    );
  }

  // Method to convert TaskModel to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'description': description,
      'toolsNeeded': toolsNeeded,
      'carId': carId,
      'userCreated': userCreated ? 1 : 0,
      'verifiedManualId': verifiedManualId,
      'currentStepNumber': currentStepNumber,
      'completedDate': completedDate,
      'completedMileage': completedMileage,
      'refrenceUrl': refrenceUrl,
      'id': id
    };
  }
}