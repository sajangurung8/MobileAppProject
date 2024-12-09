// lib/main.dart
import 'package:car_care_log_app/services/reminder_scheduler.dart';
import 'package:car_care_log_app/services/reminder_service.dart';
import 'package:car_care_log_app/view/add_car_screen.dart';
import 'package:car_care_log_app/view/add_task_screen.dart';
import 'package:car_care_log_app/view/car_info_screen.dart';
import 'package:car_care_log_app/view/reminder_screen.dart';
import 'package:car_care_log_app/view/report_screen.dart';
import 'package:car_care_log_app/viewmodel/reminder_view_model.dart';
import 'package:car_care_log_app/viewmodel/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/car_view_model.dart';
import 'view/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarViewModel()..loadCars()),
        ChangeNotifierProvider(create: (context) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => ReminderViewModel()),
        Provider(create: (_) => ReminderScheduler()..start(),),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Care Log',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
        '/addCarScreen': (context) => AddCarScreen(), 
        '/carInfoScreen': (context) => CarInfoScreen(carId: ModalRoute.of(context)!.settings.arguments as int),
        '/addTaskScreen': (context) => AddTaskScreen(carId: ModalRoute.of(context)!.settings.arguments as int),
        '/reminder': (context) => ReminderScreen(),
        '/report':(context) => const ReportScreen()
      },
    );
  }
}
