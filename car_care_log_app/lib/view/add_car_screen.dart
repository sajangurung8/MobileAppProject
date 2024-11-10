// lib/views/add_car_screen.dart
import 'package:car_care_log_app/model/car.dart';
import 'package:car_care_log_app/viewmodel/car_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCarScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Car Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _makeController,
                decoration: const InputDecoration(labelText: 'Make'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car make(For example: Toyota, Honda, etc.)';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model of your car.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Car Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter year of your car.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mileageController,
                decoration: const InputDecoration(labelText: 'Current Mileage'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mileage';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _mileageController.text.isNotEmpty &&
                      _makeController.text.isNotEmpty &&
                      _modelController.text.isNotEmpty &&
                      _yearController.text.isNotEmpty &&
                      int.tryParse(_yearController.text) != null &&
                      int.tryParse(_mileageController.text) != null) {
                    final carName = _nameController.text;
                    final currentMileage = int.parse(_mileageController.text);
                    final model = _modelController.text;
                    final make = _makeController.text;
                    final year = int.parse(_yearController.text);

                    // Create a new CarModel object
                    final newCar = CarModel(
                      name: carName,
                      currentMileage: currentMileage,
                      make: make,
                      model: model,
                      year: year
                    );

                    // Use the CarViewModel to add the new car to the database
                    Provider.of<CarViewModel>(context, listen: false)
                        .addCar(newCar);

                    // Go back to the previous screen after adding
                    Navigator.pop(context);
                  } else {
                    // Display validation error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill out all fields correctly.')),
                    );
                  }
                },
                child: const Text('Add Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
