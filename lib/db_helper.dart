import 'package:mobile_app/module_model.dart';
import 'package:mobile_app/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'student.db');
    String pathm = join(documentDirectory.path, 'module.db');
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, prenom TEXT, email TEXT, password TEXT)');
    await db
        .execute('CREATE TABLE module (id INTEGER PRIMARY KEY, namem TEXT)');
  }

  Future<Student> add(Student student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student;
  }

  Future<Module> addm(Module module) async {
    var dbClient = await db;
    module.id = await dbClient.insert('module', module.toMap());
    return module;
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('student', columns: ['id', 'name','prenom', 'email', 'password']);
    List<Student> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Student.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<List<Module>> getModules() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('module', columns: ['id', 'namem']);
    List<Module> modules = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        modules.add(Module.fromMap(maps[i]));
      }
    }
    return modules;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'module',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> updatem(Module module) async {
    var dbClient = await db;
    return await dbClient.update(
      'module',
      module.toMap(),
      where: 'id = ?',
      whereArgs: [module.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
