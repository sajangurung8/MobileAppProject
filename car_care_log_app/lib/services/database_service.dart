// lib/services/database_service.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/car_model.dart';

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
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            currentMileage INTEGER,
            status TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carId INTEGER,
            taskName TEXT,
            description TEXT,
            toolsNeeded TEXT,
            status TEXT,
            FOREIGN KEY(carId) REFERENCES cars(id) ON DELETE CASCADE
          )
        ''');
        db.execute('''
          CREATE TABLE steps (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskId INTEGER,
            stepNumber INTEGER,
            description TEXT,
            completed INTEGER,
            FOREIGN KEY(taskId) REFERENCES tasks(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // Method to insert a car
  Future<void> insertCar(CarModel car) async {
    final db = await database;
    await db.insert('cars', car.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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
    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<TaskModel>> getTasksByCarId(int carId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks', where: 'carId = ?', whereArgs: [carId]);
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
    final List<Map<String, dynamic>> maps = await db.query('tasks', where: 'id = ?', whereArgs: [taskId]);
    return TaskModel.fromMap(maps.first);
  }

  // Update task status
  Future<void> updateTaskStatus(int taskId, String status) async {
    final db = await database;
    await db.update('tasks', {'status': status}, where: 'id = ?', whereArgs: [taskId]);
  }

  // Insert a step
  Future<void> insertStep(StepModel step, int taskId) async {
    final db = await database;
    await db.insert('steps', step.toMap(taskId), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Fetch steps by task ID
  Future<List<StepModel>> getStepsForTask(int taskId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('steps', where: 'taskId = ?', whereArgs: [taskId]);
    return List.generate(maps.length, (i) => StepModel.fromMap(maps[i]));
  }

  // Update car status based on tasks
  Future<void> _updateCarStatusBasedOnTasks(int carId) async {
    final db = await database;
    final tasks = await db.query('tasks', where: 'carId = ?', whereArgs: [carId]);

    bool allCompleted = true;
    bool hasDueTasks = false;

    for (var task in tasks) {
      if (task['status'] == 'due') {
        hasDueTasks = true;
        break;
      } else if (task['status'] != 'completed') {
        allCompleted = false;
      }
    }
    String newStatus;
    if (hasDueTasks) {
      newStatus = 'due';
    } else if (allCompleted) {
      newStatus = 'completed';
    } else {
      newStatus = 'in_progress';
    }

    await db.update(
      'cars',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [carId],
    );
  }

  // Method to update the completion status of a step
Future<void> updateStepCompletion(int stepId, bool completed) async {
  final db = await database;
  await db.update(
    'steps', // Ensure 'steps' table is correctly created
    {'completed': completed ? 1 : 0}, // SQLite stores booleans as integers (1 or 0)
    where: 'id = ?',
    whereArgs: [stepId],
  );
}
}
