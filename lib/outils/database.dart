import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:mobile_app/models/user.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String userTable = 'user_table';
  String colId = 'id';
  String colNom = 'nom';
  String colPrenom = 'prenom';
  String colEmail = 'email';
  String colPassword = 'password';
  String colTel = 'tel';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNom TEXT, $colPrenom TEXT, $colEmail TEXT, $colPassword TEXT, $colTel INTEGER)');
  }

  Future<Database> get database async{
    if(_database != null)
    {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'users.db';

    var usersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return usersDatabase;
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query(userTable);
    return result ;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result ;
  }

  Future<List<User>> getUserList() async{

    var userMapList = await getUserMapList();
    int count = userMapList.length;

    List<User> userList = List<User>();

    for(int i = 0; i<count; i++){
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }




  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'mobile_app.db'),
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE users(
            nom TEXT,
            prenom TEXT,
            email TEXT PRIMARY KEY,
            password TEXT,
            tel INTEGER
            )
            ''');
      },
      version: 1
    );
  }

  newUser(User newUser) async{
    final db = await database;
    var res = await db.rawInsert('''
      INSERT INTO users (
        nom, prenom, email, password, tel
        ) VALUES (?, ?, ?, ?, ?)
    ''',[newUser.nom, newUser.prenom, newUser.email, newUser.password, newUser.tel]);

    return res;
  }

  Future<dynamic> getUser() async{
    final db = await database;
    var res = await db.query("users");
    if(res.length == 0)
      {
        return null;
      }else{
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : null ;
    }
  }

}