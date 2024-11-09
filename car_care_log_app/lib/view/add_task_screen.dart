// lib/views/add_task_screen.dart
import 'package:car_care_log_app/model/task.dart';
import 'package:car_care_log_app/viewmodel/car_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  final int carId;

  AddTaskScreen({super.key, required this.carId});

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController toolsNeededController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController refrenceController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: taskNameController,
              decoration: const InputDecoration(
                hintText: 'Enter task name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tools Needed (comma-separated)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: toolsNeededController,
              decoration: const InputDecoration(
                hintText: 'Enter tools needed',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter task description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Refrence URI',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: refrenceController,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'Refrence Uri',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(taskNameController.text.isNotEmpty && toolsNeededController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                    final taskName = taskNameController.text;
                    final tools = toolsNeededController.text;
                    final description = descriptionController.text;
                    final refrenceUri = refrenceController.text;

                    var newTask = TaskModel(carId: carId, taskName: taskName, description: description, toolsNeeded: tools, refrenceUrl: refrenceUri, userCreated: true);

                    Provider.of<CarViewModel>(context, listen: false).addTask(newTask);

                    Navigator.pop(context, true);
                    //Navigator.pushNamed(context, '/carInfoScreen', arguments: carId);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill out all fields correctly.')),
                    );
                  }
                  // Collect data and add task
                },
                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
