// lib/models/car_model.dart
class CarModel {
  final int? id;
  final String name;
  final int currentMileage;
  final String model;
  final String make;
  final int year;

  CarModel({
    this.id,
    required this.name,
    required this.currentMileage,
    required this.make,
    required this.model,
    required this.year
  });

  // Factory method to create a CarModel from a database map
  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      name: map['name'] as String,
      currentMileage: map['currentMileage'] as int,
      make: map['make'],
      model: map['model'],
      year: map['year']
    );
  }

  // Method to convert CarModel to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currentMileage': currentMileage,
      'make': make,
      'model': model,
      'year': year
    };
  }
}
