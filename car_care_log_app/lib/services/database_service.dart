// lib/services/database_service.dart
import 'package:car_care_log_app/model/reminder.dart';
import 'package:car_care_log_app/model/step.dart';
import 'package:car_care_log_app/model/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/car.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'car_log.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
          CREATE TABLE cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            currentMileage INTEGER,
            make TEXT,
            model TEXT,
            year INTEGER
          )
        ''');
        db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carId INTEGER,
            taskName TEXT,
            description TEXT,
            toolsNeeded TEXT,
            verifiedManualId INTEGER,
            userCreated INTEGER,
            currentStepNumber INTEGER,
            completedDate TEXT,
            completedMileage INTEGER,
            refrenceUrl TEXT,
            FOREIGN KEY(carId) REFERENCES cars(id) ON DELETE CASCADE
          )
        ''');
        db.execute('''
          CREATE TABLE steps (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskId INTEGER,
            stepNumber INTEGER,
            description TEXT,
            FOREIGN KEY(taskId) REFERENCES tasks(id) ON DELETE CASCADE
          )
        ''');
        db.execute('''
          CREATE TABLE reminders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carId INTEGER,
            carName TEXT,
            carMake TEXT,
            carModel TEXT,
            carYear INTEGER,
            carCurrentMileage INTEGER,
            taskName TEXT,
            reminderDate TEXT,  -- Store as TEXT to handle SQLite date format
            reminderMileage INTEGER,
            FOREIGN KEY(carId) REFERENCES cars(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // Method to insert a car
  Future<void> insertCar(CarModel car) async {
    final db = await database;
    await db.insert('cars', car.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Method to update a car
  Future<void> updateCar(CarModel car) async {
    final db = await database;
    await db.update(
      'cars',
      car.toMap(),
      where: 'id = ?',
      whereArgs: [car.id],
    );
  }

  // Method to delete a car
  Future<void> deleteCar(int id) async {
    final db = await database;
    await db.delete(
      'cars',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Method to fetch all cars
  Future<List<CarModel>> getCars() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cars');

    return List.generate(maps.length, (i) {
      return CarModel.fromMap(maps[i]);
    });
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<TaskModel>> getTasksByCarId(int carId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('tasks', where: 'carId = ?', whereArgs: [carId]);
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  // Update car status
  Future<void> updateCarStatus(int carId, String status) async {
    final db = await database;
    await db.update(
      'cars',
      {'status': status},
      where: 'id = ?',
      whereArgs: [carId],
    );
  }

  // Get task by ID
  Future<TaskModel> getTaskById(int taskId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('tasks', where: 'id = ?', whereArgs: [taskId]);
    return TaskModel.fromMap(maps.first);
  }

  // Update task status
  Future<void> updateTaskStatus(int taskId, String status) async {
    final db = await database;
    await db.update('tasks', {'status': status},
        where: 'id = ?', whereArgs: [taskId]);
  }

  // Insert a step
  Future<void> insertStep(StepModel step, int taskId) async {
    final db = await database;
    await db.insert('steps', step.toMap(taskId),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Fetch steps by task ID
  Future<List<StepModel>> getStepsForTask(int taskId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('steps', where: 'taskId = ?', whereArgs: [taskId]);
    return List.generate(maps.length, (i) => StepModel.fromMap(maps[i]));
  }

  Future<int> insertReminder(Reminder reminder) async {
    final db = await database;
    return await db.insert('reminders', reminder.toMap());
  }

  Future<List<Reminder>> getAllReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders');
    return List.generate(maps.length, (i) {
      return Reminder.fromMap(maps[i]);
    });
  }

  Future<List<Map<String, dynamic>>> getAllRemindersWithCarInfo(
      Database db) async {
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT 
      reminders.id AS reminderId,
      reminders.taskName,
      reminders.reminderDate,
      reminders.reminderMileage,
      cars.name AS carName,
      cars.currentMileage AS carCurrentMileage,
      cars.make AS carMake,
      cars.model AS carModel,
      cars.year AS carYear
    FROM reminders
    JOIN cars ON reminders.carId = cars.id
  ''');

    return results
        .map((reminder) => {
              'reminderId': reminder['reminderId'],
              'taskName': reminder['taskName'],
              'reminderDate': reminder['reminderDate'],
              'reminderMileage': reminder['reminderMileage'],
              'carName': reminder['carName'],
              'carCurrentMileage': reminder['carCurrentMileage'],
              'carMake': reminder['carMake'],
              'carModel': reminder['carModel'],
              'carYear': reminder['carYear'],
            })
        .toList();
  }

  Future<void> updateCarMileage(int carId, int newMileage) async {
    final db = await database;
    await db.update(
      'cars',
      {'currentMileage': newMileage},
      where: 'id = ?',
      whereArgs: [carId],
    );
  }
}
