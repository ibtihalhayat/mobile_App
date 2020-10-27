import 'package:mobile_app/models/chapitre.dart';
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

  // La tabke ETUDIANT
  String userTable = 'user_table';
  String colId = 'id';
  String colNom = 'nom';
  String colPrenom = 'prenom';
  String colEmail = 'email';
  String colPassword = 'password';
  String colTel = 'tel';
  String colPriority = 'priority';
  String colDate = 'date';

  // La table MODULE
  String moduleTable = 'module';
  String colIdm = 'idm';
  String colNomm = 'nomm';
  String colNbchapitres = 'nbchapitres';

  // La table CHAPITRE
  String chapitreTable = 'chapitre';
  String colIdc = 'idc';
  String colNomcours = 'nomcours';
  String colNumchapitre = 'numchapitre';
  String colDone = 'done';



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
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'mobileapp.db';

    // Ouvrir/Créer la BD
    var usersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return usersDatabase;
  }

  //Création de la BD
  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNom TEXT, $colPrenom TEXT, '
        '$colEmail TEXT, $colPassword TEXT, $colTel TEXT, $colPriority INTEGER, $colDate TEXT)');
    await db.execute('CREATE TABLE $moduleTable($colIdm INTEGER PRIMARY KEY AUTOINCREMENT, $colNomm TEXT, $colNbchapitres TEXT)');
    await db.execute('CREATE TABLE $chapitreTable($colIdc INTEGER PRIMARY KEY AUTOINCREMENT, $colNomcours TEXT, $colNumchapitre TEXT, $colDone TEXT)');
  }

  // Get les Objets Etudiant depuis la BD
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(userTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Get les Objets Module depuis la BD
  Future<List<Map<String, dynamic>>> getModuleMapList() async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(moduleTable, orderBy: '$colNomm ASC');
    return result;
  }

  // Get les Objets Chapitre depuis la BD
  Future<List<Map<String, dynamic>>> getChapitreMapList(String nomchoisi) async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $chapitreTable order by $colPriority ASC');
    var result = await db.rawQuery('SELECT * FROM $chapitreTable WHERE $colNomcours = ?',[nomchoisi]);
    print(result);
    return result;
  }

  /*Future<void> getChapitreDone(String nomcourschoisi, String numchapitrechoisi) async {
    Database db = await this.database;

    var chapitreMapList = await getChapitreMapList(nomcourschoisi);
//		var result = await db.rawQuery('SELECT * FROM $chapitreTable order by $colPriority ASC');
    var result = await db.rawQuery('SELECT $colDone FROM $chapitreTable WHERE $colNomcours = ? AND $colNumchapitre = ?',[nomcourschoisi, numchapitrechoisi]);
    print(result);
  }*/


  // Inserer l'object Etudiant à la BD
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }
  // Inserer l'object Module à la BD
  Future<int> insertModule(Module module) async {
    Database db = await this.database;
    var result = await db.insert(moduleTable, module.toMap());
    return result;
  }
  // Inserer l'object Chapitre à la BD
  Future<int> insertChapitre(Chapitre chapitre) async {
    Database db = await this.database;
    var result = await db.insert(chapitreTable, chapitre.toMap());
    return result;
  }


  // Mettre à jour l'objet Etudiant et enregistrer les modifications
  Future<int> updateUser(User user) async {
    var db = await this.database;
    var result = await db.update(userTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }
  // Mettre à jour l'objet Module et enregistrer les modifications
  Future<int> updateModule(Module module) async {
    var db = await this.database;
    var result = await db.update(moduleTable, module.toMap(), where: '$colIdm = ?', whereArgs: [module.idm]);
    return result;
  }
  // Mettre à jour l'objet Chapitre et enregistrer les modifications
  Future<int> updateChapitre(String nomcourschoisi, String numchapitrechoisi) async {
    var db = await this.database;
  //  var result = await db.update(moduleTable, module.toMap(), where: '$colIdm = ?', whereArgs: [module.idm]);
    var result = await db.rawUpdate('UPDATE $chapitreTable SET $colDone = ? WHERE $colNomcours = ? AND $colNumchapitre = ?',['1',nomcourschoisi,numchapitrechoisi]);
    return result;
  }


  // Supprimer l'objet Etudiant de la BD
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;
  }
  // Supprimer l'objet Module de la BD
  Future<int> deleteModule(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $moduleTable WHERE $colIdm = $id');
    return result;
  }

  // Get le nombre des Etudiants
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  //Get le nombre des Modules
  Future<int> getCountm() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $moduleTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get 'Map List' [ List<Map> ] et la convertir à 'List Etudiant'
  Future<List<User>> getUserList() async {

    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length;         // nombre de map dans la BD
    List<User> userList = List<User>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  // Get 'Map List' [ List<Map> ] et la convertir à 'List Module'
  Future<List<Module>> getModuleList() async {

    var moduleMapList = await getModuleMapList(); // Get 'Map List' from database
    int count = moduleMapList.length;      // Nombre de map dans la BD
    List<Module> moduleList = List<Module>();
    for (int i = 0; i < count; i++) {
      moduleList.add(Module.fromMapObject(moduleMapList[i]));
    }
    return moduleList;
  }

  // Get 'Map List' [ List<Map> ] et la convertir à 'List Chapitre'
  Future<List<Chapitre>> getChapitreList(String nomchoisi) async {

    var chapitreMapList = await getChapitreMapList(nomchoisi); // Get 'Map List' from database
    int count = chapitreMapList.length;         // Nombre de map dans la BD
    List<Chapitre> chapitreList = List<Chapitre>();
    for (int i = 0; i < count; i++) {
      chapitreList.add(Chapitre.fromMapObject(chapitreMapList[i]));
    }
    return chapitreList;
  }

}