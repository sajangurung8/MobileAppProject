class StepModel {
  final int? id;
  final int taskId;
  final int stepNumber;
  final String description;

  StepModel({
    this.id,
    required this.taskId,
    required this.stepNumber,
    required this.description,
  });

  // Factory method to create StepModel from a database map
  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      id: map['id'] as int?,
      taskId: map['taskId'] as int,
      stepNumber: map['stepNumber'] as int,
      description: map['description'] as String
    );
  }

  // Method to convert StepModel to a map for database insertion
  Map<String, dynamic> toMap(int taskId) {
    return {
      'id': id,
      'taskId': taskId,
      'stepNumber': stepNumber,
      'description': description,
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
    );
  }
}