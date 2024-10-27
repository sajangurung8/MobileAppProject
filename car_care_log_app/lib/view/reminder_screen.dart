import 'package:car_care_log_app/view/navigation_bar.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Reminder Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Space between title and reminders
            Text(
              '• Oil change after 10,000 miles',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '• Tire change in 50,000 miles',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(selectedIndex: 1),
    );
  }
}
