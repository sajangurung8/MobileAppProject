// lib/views/add_car_screen.dart
import 'package:car_care_log_app/model/car_model.dart';
import 'package:car_care_log_app/viewmodel/car_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCarScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter status of this car';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _mileageController.text.isNotEmpty &&
                      _statusController.text.isNotEmpty &&
                      int.tryParse(_mileageController.text) != null) {
                    final carName = _nameController.text;
                    final currentMileage = int.parse(_mileageController.text);
                    final status = _statusController.text;

                    // Create a new CarModel object
                    final newCar = CarModel(
                      name: carName,
                      currentMileage: currentMileage,
                      status: status,
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
