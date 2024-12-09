import 'dart:async';
import 'package:car_care_log_app/services/reminder_service.dart';

class ReminderScheduler {
  static final ReminderScheduler _instance = ReminderScheduler._internal();
  factory ReminderScheduler() => _instance;

  final ReminderService _reminderService = ReminderService();
  Timer? _reminderCheckTimer;

  ReminderScheduler._internal() {
    _reminderService.initNotifications();
  }

  // Start periodic reminder checks
  void start() {
    _reminderCheckTimer ??= Timer.periodic(
      const Duration(minutes: 60), 
      (timer) async {
        await _reminderService.checkRemindersByDate();
      },
    );
  }

  // Stop the periodic reminder checks
  void stop() {
    _reminderCheckTimer?.cancel();
    _reminderCheckTimer = null;
  }

  // Manually trigger reminder checks by mileage and date
  Future<void> triggerManualReminderCheck(carViewModel) async {
    try {
      // Check reminders by mileage
      await _reminderService.checkReminders(carViewModel);

      // Additionally check reminders by date
      await _reminderService.checkRemindersByDate();
    } catch (e) {
      // Handle exceptions that may arise during the reminder check
      print('Error during manual reminder check: $e');
    }
  }
}
