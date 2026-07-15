import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/patient_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dr_venus.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE patients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patientId TEXT,
        name TEXT,
        age INTEGER,
        gender TEXT,
        mobile TEXT,
        address TEXT,
        branch TEXT,
        doctor TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertPatient(Map<String, dynamic> patient) async {
    final db = await database;
    return await db.insert('patients', patient);
  }

  Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await database;
    return await db.query('patients', orderBy: 'id DESC');
  }

  Future<List<Patient>> getAllPatients() async {
    final db = await database;

    final result = await db.query('patients', orderBy: 'id DESC');

    return result.map((e) => Patient.fromMap(e)).toList();
  }

  Future<int> updatePatient(int id, Map<String, dynamic> patient) async {
    final db = await database;
    return await db.update(
      'patients',
      patient,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePatient(int id) async {
    final db = await database;
    return await db.delete('patients', where: 'id = ?', whereArgs: [id]);
  }
}
