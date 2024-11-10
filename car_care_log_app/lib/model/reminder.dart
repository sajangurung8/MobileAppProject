class Reminder {
  int? id;
  String reminderDate; // Store as ISO 8601 string (e.g., '2024-11-06')
  int reminderMileage;
  int? carId;
  String carName;
  String? carMake; // stiring combination of year make model of a car
  String carModel;
  int carYear;
  int carCurrentMileage;
  String taskName;

  Reminder({
    this.id,
    this.carId,
    required this.carName,
    required this.carYear,
    this.carMake,
    required this.carModel,
    required this.carCurrentMileage,
    required this.taskName,
    required this.reminderDate,
    required this.reminderMileage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reminderDate': reminderDate,
      'reminderMileage': reminderMileage,
      'carId': carId,
      'carName': carName,
      'carModel': carModel,
      'carMake': carMake,
      'carYear': carYear,
      'taskName': taskName,
      'carCurrentMileage': carCurrentMileage
    };
  }

  static Reminder fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      carId: map['carId'] ?? 0,
      reminderDate: map['reminderDate'] ?? '1970-01-01',
      reminderMileage: map['reminderMileage'] ?? 0,
      carModel: map['carModel'] ?? 'Unknown Model',
      carName: map['carName'] ?? 'Unknown Car',
      carMake: map['carMake'] ?? 'Unknown',
      carYear: map['carYear'] ?? 0,
      carCurrentMileage: map['carCurrentMileage'] ?? 0,
      taskName: map['taskName'] ?? 'Unknown Task'
    );
  }
}