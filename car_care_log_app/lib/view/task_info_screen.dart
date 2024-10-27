// lib/views/task_info_screen.dart
import 'package:car_care_log_app/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/task_view_model.dart';

class TaskInfoScreen extends StatelessWidget {
  final int taskId;

  const TaskInfoScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return FutureBuilder<TaskModel>(
      future: taskViewModel.getTaskById(taskId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Task Info')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Task Info')),
            body: const Center(child: Text('Task information not available.')),
          );
        }

        final task = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text('${task.taskName} Info'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tools Needed: ${task.toolsNeeded}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Description: ${task.description}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Divider(),
                const Text(
                  'Steps:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: FutureBuilder<List<StepModel>>(
                    future: taskViewModel.getStepsByTaskId(taskId),
                    builder: (context, stepsSnapshot) {
                      if (stepsSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (stepsSnapshot.hasError || !stepsSnapshot.hasData) {
                        return const Center(child: Text('No steps available.'));
                      }

                      final steps = stepsSnapshot.data!;
                      return ListView.builder(
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          final step = steps[index];
                          return ListTile(
                            title: Text('Step ${step.stepNumber}: ${step.description}'),
                            trailing: Checkbox(
                              value: step.completed,
                              onChanged: (value) {
                                taskViewModel.updateStepCompletion(step.id!, value ?? false);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _AddStepForm(taskId: taskId),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddStepForm extends StatefulWidget {
  final int taskId;

  const _AddStepForm({Key? key, required this.taskId}) : super(key: key);

  @override
  _AddStepFormState createState() => _AddStepFormState();
}

class _AddStepFormState extends State<_AddStepForm> {
  final TextEditingController _stepDescriptionController = TextEditingController();
  bool _isAddingStep = false; // Flag to control visibility of step input

  @override
  void dispose() {
    _stepDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isAddingStep) ...[
          // Show the text field and complete button when adding a step
          TextField(
            controller: _stepDescriptionController,
            decoration: const InputDecoration(
              labelText: 'New Step Description',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_stepDescriptionController.text.isNotEmpty) {
                    taskViewModel.addStep(widget.taskId, _stepDescriptionController.text);
                    _stepDescriptionController.clear(); // Clear the text field
                    setState(() {
                      _isAddingStep = false; // Hide the input after adding
                    });
                  }
                },
                child: const Text('Complete'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isAddingStep = false; // Cancel adding a step
                  });
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ] else ...[
          // Show "Add Step" button when not adding a step
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isAddingStep = true; // Show text field and buttons
              });
            },
            child: const Text('Add Step'),
          ),
        ],
      ],
    );
  }
}
