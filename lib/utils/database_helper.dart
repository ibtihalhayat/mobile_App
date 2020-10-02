import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/models/module.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mobile_app/screens/user_detail.dart';
import 'package:mobile_app/screens/module_detail.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String userTable = 'user_table';
  String colId = 'id';
  String colNom = 'nom';
  String colPrenom = 'prenom';
  String colEmail = 'email';
  String colPassword = 'password';
  String colTel = 'tel';
  String colPriority = 'priority';
  String colDate = 'date';

  String moduleTable = 'module';
  String colIdm = 'idm';
  String colNomm = 'nomm';
  String colNbchapitres = 'nbchapitres';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'mobileapp.db';

    // Open/create the database at a given path
    var usersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return usersDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNom TEXT, $colPrenom TEXT, '
        '$colEmail TEXT, $colPassword TEXT, $colTel TEXT, $colPriority INTEGER, $colDate TEXT)');
    await db.execute('CREATE TABLE $moduleTable($colIdm INTEGER PRIMARY KEY AUTOINCREMENT, $colNomm TEXT, $colNbchapitres TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(userTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getModuleMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(moduleTable, orderBy: '$colNomm ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }
  Future<int> insertModule(Module module) async {
    Database db = await this.database;
    var result = await db.insert(moduleTable, module.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateUser(User user) async {
    var db = await this.database;
    var result = await db.update(userTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }
  Future<int> updateModule(Module module) async {
    var db = await this.database;
    var result = await db.update(moduleTable, module.toMap(), where: '$colIdm = ?', whereArgs: [module.idm]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;
  }
  Future<int> deleteModule(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $moduleTable WHERE $colIdm = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<int> getCountm() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $moduleTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<User>> getUserList() async {

    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length;         // Count the number of map entries in db table

    List<User> userList = List<User>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }

    return userList;
  }
  Future<List<Module>> getModuleList() async {

    var moduleMapList = await getModuleMapList(); // Get 'Map List' from database
    int count = moduleMapList.length;         // Count the number of map entries in db table

    List<Module> moduleList = List<Module>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      moduleList.add(Module.fromMapObject(moduleMapList[i]));
    }

    return moduleList;
  }

}