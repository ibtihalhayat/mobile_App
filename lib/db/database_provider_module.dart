/*import 'package:mobile_app/models/module.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_MODULE = "module";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NOM = "nom";
  static const String COLUMN_NBCHAPITRES = "nbchapitres";

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
      join(dbPath, 'moduleDB.db'),
      version: 2,
      onCreate: (Database database, int version) async {
        print("Creating module table");

        await database.execute(
            "CREATE TABLE $TABLE_MODULE ("
                "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
                "$COLUMN_NOM TEXT, "
                "$COLUMN_NBCHAPITRES TEXT)"
        );
      },
    );
  }

  Future<List<Module>> getModules() async {
    final db = await database;

    var modules = await db
        .query(TABLE_MODULE, columns: [COLUMN_ID, COLUMN_NOM,COLUMN_NBCHAPITRES]);

    List<Module> moduleList = List<Module>();

    modules.forEach((currentModule) {
      Module module = Module.fromMap(currentModule);

      moduleList.add(module);
    });

    return moduleList;
  }

  Future<Module> insert(Module module) async {
    final db = await database;
    module.id = await db.insert(TABLE_MODULE, module.toMap());
    return module;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_MODULE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Module module) async {
    final db = await database;

    return await db.update(
      TABLE_MODULE,
      module.toMap(),
      where: "id = ?",
      whereArgs: [module.id],
    );
  }
}*/
