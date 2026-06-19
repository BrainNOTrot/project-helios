import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('helios.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE missions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        progress REAL NOT NULL
      )
    ''');

    await db.execute('''
    CREATE TABLE habits(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      completed INTEGER NOT NULL
    )
  ''');
  }

  Future<int> insertMission(Map<String, dynamic> row) async {
    final db = await instance.database;

    return await db.insert(
      'missions',
      row,
    );
  }

  Future<List<Map<String, dynamic>>> getAllMissions() async {
    final db = await instance.database;

    return await db.query('missions');
  }

  Future<int> updateMission(Map<String, dynamic> row) async {
    final db = await instance.database;

    return await db.update(
      'missions',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> deleteMission(int id) async {
    final db = await instance.database;

    return await db.delete(
      'missions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertHabit(Map<String, dynamic> row) async {
    final db = await instance.database;

    return await db.insert(
      'habits',
      row,
    );
  }

  Future<List<Map<String, dynamic>>> getAllHabits() async {
    final db = await instance.database;

    return await db.query('habits');
  }

  Future<int> updateHabit(Map<String, dynamic> row) async {
    final db = await instance.database;

    return await db.update(
      'habits',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> deleteHabit(int id) async {
    final db = await instance.database;

    return await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}