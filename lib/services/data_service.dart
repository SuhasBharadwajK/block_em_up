import 'package:block_em_up/models/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  static String dbName = "blocked_numbers_database.db";
  static String tableName = "BlockedNumbers";
  final String dbCreateQuery = "CREATE TABLE " + tableName + "(id INTEGER PRIMARY KEY AUTOINCREMENT, blockingPattern TEXT, isBlockingActive INTEGER, dateCreated TEXT, dateModified TEXT)";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    var theDb = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        return db.execute(this.dbCreateQuery);
      }
    );

    return theDb;
  }

  Future<List<Map<String, dynamic>>> getAllEntities<T>(String tableName) async {
    return await (await this.db).query(tableName);
  }

  Future<int> insert(DataEntity dataEntity, String tableName) async {
    return await (await this.db).insert(tableName, dataEntity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
