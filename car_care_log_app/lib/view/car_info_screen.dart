import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/car_view_model.dart';
import '../model/task.dart';
import '../view/task_info_screen.dart';

class CarInfoScreen extends StatefulWidget {
  final int carId;

  const CarInfoScreen({Key? key, required this.carId}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  late int currentMileage;

  @override
  void initState() {
    super.initState();
    final carViewModel = Provider.of<CarViewModel>(context, listen: false);
    final car = carViewModel.getCarById(widget.carId);
    if (car != null) {
      currentMileage = car.currentMileage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final carViewModel = Provider.of<CarViewModel>(context);
    final car = carViewModel.getCarById(widget.carId);

    if (car == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Car Info')),
        body: const Center(child: Text('Car information not available.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Car Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(car.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('${car.year} ${car.make} ${car.model}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Odometer reading: $currentMileage miles',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _showMileageUpdateDialog(context, carViewModel, widget.carId),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text('Tasks:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<TaskModel>>(
                future: carViewModel.getTasksByCarId(widget.carId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading tasks'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No tasks added yet.'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final task = snapshot.data![index];
                      return ListTile(
                        title: Text(task.taskName),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskInfoScreen(taskId: task.id!),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMileageUpdateDialog(BuildContext context, CarViewModel carViewModel, int carId) {
    final TextEditingController mileageController = TextEditingController(text: currentMileage.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Mileage'),
        content: TextField(
          controller: mileageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter new mileage'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newMileage = int.tryParse(mileageController.text);
              if (newMileage != null && newMileage >= currentMileage) {
                setState(() {
                  currentMileage = newMileage;
                });
                carViewModel.updateCarMileage(carId, newMileage);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid mileage input.')),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
