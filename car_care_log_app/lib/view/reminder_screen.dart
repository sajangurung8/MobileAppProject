import 'package:car_care_log_app/view/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_care_log_app/viewmodel/reminder_view_model.dart';

class ReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReminderViewModel()..fetchAllReminders(),
      child: Consumer<ReminderViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: Text('All Reminders')),
            body: viewModel.reminders.isEmpty ?  
            Center(child: Text('No reminders yet'))
            :
            ListView.builder(
              itemCount: viewModel.reminders.length,
              itemBuilder: (context, index) {
                final reminder = viewModel.reminders[index];
                return ListTile(
                  title: Text('Task: ${reminder.taskName}'),
                  subtitle: Text('Due after ${reminder.reminderMileage - reminder.carCurrentMileage} or on ${reminder.reminderDate}'),
                  trailing: Text('${reminder.carName}: ${reminder.carYear} ${reminder.carModel}'),
                );
              },
            ),
            bottomNavigationBar: const AppBottomNavigationBar(selectedIndex: 0),
          );
        },
      ),
    );
  }
}
