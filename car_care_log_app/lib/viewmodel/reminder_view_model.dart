import 'package:car_care_log_app/model/reminder.dart';
import 'package:flutter/material.dart';
import 'package:car_care_log_app/services/database_service.dart';

class ReminderViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  Future<void> fetchAllReminders() async {
    _reminders = await _databaseService.getAllReminders();
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    await _databaseService.insertReminder(reminder);
    await fetchAllReminders();
  }
}
