import 'package:mobile_app/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_USER = "user";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NOM = "nom";
  static const String COLUMN_PRENOM = "prenom";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_PASSWORD = "password";
  static const String COLUMN_TEL = "tel";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'userDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating user table");

        await database.execute(
          "CREATE TABLE $TABLE_USER ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_NOM TEXT,"
              "$COLUMN_PRENOM TEXT,"
              "$COLUMN_EMAIL TEXT,"
              "$COLUMN_PASSWORD TEXT,"
              "$COLUMN_TEL INTEGER"
              ")",
        );
      },
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;

    var users = await db
        .query(TABLE_USER, columns: [COLUMN_ID, COLUMN_NOM, COLUMN_PRENOM, COLUMN_EMAIL, COLUMN_PASSWORD, COLUMN_TEL]);

    List<User> userList = List<User>();

    users.forEach((currentUser) {
      User user = User.fromMap(currentUser);

      userList.add(user);
    });

    return userList;
  }

  Future<User> insert(User user) async {
    final db = await database;
    user.id = await db.insert(TABLE_USER, user.toMap());
    return user;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_USER,
      where: "id = ?",
      whereArgs: [id],
    );
  }

}