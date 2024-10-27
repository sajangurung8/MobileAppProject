// lib/views/car_info_screen.dart
import 'package:car_care_log_app/model/car_model.dart';
import 'package:car_care_log_app/view/add_task_screen.dart';
import 'package:car_care_log_app/view/task_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/car_view_model.dart';

class CarInfoScreen extends StatelessWidget {
  final int carId;

  const CarInfoScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    final carViewModel = Provider.of<CarViewModel>(context);
    final car = carViewModel.getCarById(carId);

    // Display loading message if car data is not available
    if (car == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Car Info')),
        body: const Center(child: Text('Car information not available.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${car.name} Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              car.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Mileage: ${car.currentMileage} miles',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Status: ${car.status}',
              style: TextStyle(
                fontSize: 18,
                color: _getStatusColor(car.status),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Tasks:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<TaskModel>>(
                future: carViewModel.getTasksByCarId(carId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading tasks'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text(
                      'No tasks added yet. Click on the green button below to add a new task. :)',
                      style: TextStyle(fontSize: 15),
                    ));
                  }

                  final tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        title: Text(task.taskName),
                        subtitle: Text('Status: ${task.status}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskInfoScreen(
                                  taskId: task.id!, // Pass the taskId you need
                                ),
                              ));
                          // Implement navigation to task details screen
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Add Task Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTaskScreen(carId: carId),
                      ),
                    ).then((_) {
                      // Optionally refresh the tasks when returning from the AddTaskScreen
                      Provider.of<CarViewModel>(context, listen: false)
                          .loadCars();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Set the text color
                  ),
                  child: Text('Add New Task')),
            ),
          ],
        ),
      ),
    );
  }

  // Status color based on the car's maintenance status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'no_maintenance_needed':
        return Colors.green;
      case 'in_progress':
        return Colors.amber;
      case 'due':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
