import 'package:car_care_log_app/model/reminder.dart';
import 'package:car_care_log_app/model/step.dart';
import 'package:car_care_log_app/model/task.dart';
import 'package:car_care_log_app/viewmodel/car_view_model.dart';
import 'package:car_care_log_app/viewmodel/reminder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../viewmodel/task_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskInfoScreen extends StatefulWidget {
  final int taskId;

  const TaskInfoScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  _TaskInfoScreenState createState() => _TaskInfoScreenState();
}

class _TaskInfoScreenState extends State<TaskInfoScreen>
    with WidgetsBindingObserver {
  int currentStep = 0;
  bool _isAddingStep = false;
  final TextEditingController _stepDescriptionController =
      TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stepDescriptionController.dispose();
    _youtubeUrlController.dispose();
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      //_saveCurrentStep();
    }
  }

  void _loadVideo() async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    final task = await taskViewModel.getTaskById(widget.taskId);

    if (task.refrenceUrl != null) {
      final String url = task.refrenceUrl!;
      if (url.isNotEmpty && YoutubePlayer.convertUrlToId(url) != null) {
        final uri = Uri.parse(url);
        launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid or non-YouTube URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    final reminderViewModel = Provider.of<ReminderViewModel>(context);
    final carViewModel = Provider.of<CarViewModel>(context);

    return FutureBuilder<TaskModel>(
      future: taskViewModel.getTaskById(widget.taskId),
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
            title: Text('Task Information'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
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
                  'Reference Video:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _loadVideo,
                  child: const Text('Watch Video'),
                ),
                const SizedBox(height: 16),
                if (_youtubePlayerController != null)
                  YoutubePlayer(
                    controller: _youtubePlayerController!,
                    showVideoProgressIndicator: true,
                  ),
                const Divider(),
                const Text(
                  'Steps:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: FutureBuilder<List<StepModel>>(
                    future: taskViewModel.getStepsByTaskId(widget.taskId),
                    builder: (context, stepsSnapshot) {
                      if (stepsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (stepsSnapshot.hasError ||
                          !stepsSnapshot.hasData) {
                        return const Center(child: Text('No steps available.'));
                      }

                      final steps = stepsSnapshot.data!;
                      if (steps.isEmpty)
                        return const Center(child: Text('No steps available.'));

                      // Ensure currentStep is within bounds
                      if (currentStep >= steps.length) {
                        currentStep = steps.length - 1;
                      }
                      return Stepper(
                        currentStep: currentStep,
                        onStepContinue: currentStep < steps.length - 1
                            ? () => setState(() => currentStep++)
                            : null,
                        onStepCancel: currentStep > 0
                            ? () => setState(() => currentStep--)
                            : null,
                        steps: steps.map((step) {
                          return Step(
                            title: Text('Step ${step?.stepNumber}'),
                            content: Text(step.description),
                            isActive: currentStep == step.stepNumber - 1,
                          );
                        }).toList(),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return Row(
                            children: <Widget>[
                              if (currentStep >
                                  0) // Show 'Previous' button if not on the first step
                                ElevatedButton(
                                  onPressed: details.onStepCancel,
                                  child: const Text('Previous'),
                                ),
                              if (currentStep < steps.length - 1)
                                ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  child: const Text('Next'),
                                ),
                              if (currentStep == steps.length - 1)
                                ElevatedButton(
                                  onPressed: () {
                                    _showAddReminderDialog(
                                        context,
                                        reminderViewModel,
                                        taskViewModel,
                                        carViewModel);
                                  },
                                  child: const Text('Mark as Complete'),
                                ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (_isAddingStep)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                taskViewModel.addStep(widget.taskId,
                                    _stepDescriptionController.text);
                                _stepDescriptionController.clear();
                                setState(() {
                                  _isAddingStep = false;
                                });
                              }
                            },
                            child: const Text('Add Step'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAddingStep = false;
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isAddingStep = true;
                      });
                    },
                    child: const Text('Add Step'),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddReminderDialog(
      BuildContext context,
      ReminderViewModel reminderViewModel,
      TaskViewModel taskViewModel,
      CarViewModel carViewModel) async {
    var currentTask = await taskViewModel.getTaskById(widget.taskId);

    final dateController = TextEditingController();
    final mileageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(currentTask.taskName),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: dateController,
                  decoration:
                      const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                ),
                TextField(
                  controller: mileageController,
                  decoration:
                      const InputDecoration(labelText: 'Reminder Mileage'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                var car = carViewModel.getCarById(currentTask!.carId);
                final reminder = Reminder(
                  carName: car!.name,
                  carYear: car!.year,
                  carModel: car!.model,
                  carMake: car.make,
                  carId: car.id,
                  carCurrentMileage: carViewModel
                      .getCarById(currentTask.carId)!
                      .currentMileage,
                  taskName: currentTask.taskName,
                  reminderDate: dateController.text,
                  reminderMileage: int.tryParse(mileageController.text) ?? 0,
                );
                reminderViewModel.addReminder(reminder);

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Successfully added reminder for task: ${currentTask.taskName}')));
                Navigator.pushNamed(context, "/reminder",
                    arguments: currentTask.carId);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
