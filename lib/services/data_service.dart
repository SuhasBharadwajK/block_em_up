import 'package:block_em_up/models/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  final String dbCreateQuery = "CREATE TABLE BlockedNumbers(id INTEGER PRIMARY KEY AUTOINCREMENT, blockingPattern TEXT, isBlockingActive INTEGER, dateCreated TEXT, dateModified TEXT)";
  final String dbName = "blocked_numbers_database.db";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, this.dbName);

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
