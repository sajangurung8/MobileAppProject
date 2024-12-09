import 'package:car_care_log_app/model/reminder.dart';
import 'package:car_care_log_app/services/database_service.dart';
import 'package:car_care_log_app/viewmodel/car_view_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class ReminderService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final DatabaseService databaseService = DatabaseService();

  // Initialize notifications for both iOS and Android
  void initNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap actions
        print("Notification clicked: ${response.payload}");
      },
    );

    requestPermissions();
  }

  Future<void> requestPermissions() async {
    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    print('Notification permission result: $result');
  }

  // Check reminders by date and send notifications if due
  Future<void> checkRemindersByDate() async {
    final reminders = await fetchRemindersFromDatabase();

    for (var reminder in reminders) {
      DateTime reminderDate = DateTime.parse(reminder.reminderDate);

      if (reminderDate.isBefore(DateTime.now()) || reminderDate.isAtSameMomentAs(DateTime.now())) {
        _sendNotification(reminder);
      }
    }
  }

  // Check reminders by mileage and send notifications if due
  Future<void> checkReminders(CarViewModel carViewModel) async {
    final reminders = await fetchRemindersFromDatabase();

    for (var reminder in reminders) {
      final car = carViewModel.getCarById(reminder.carId!);
      if (car != null && reminder.reminderMileage <= car.currentMileage) {
        _sendNotification(reminder);
      }
    }
  }

  // Fetch reminders from the database
  Future<List<Reminder>> fetchRemindersFromDatabase() async {
    return databaseService.getAllReminders();
  }

  // Send notification for a specific reminder
  void _sendNotification(Reminder reminder) {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      channelDescription: 'Notification channel for reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      reminder.id!,
      'Reminder: ${reminder.taskName}',
      'Reminder for task due: ${reminder.reminderDate}',
      notificationDetails,
    );
  }
}
