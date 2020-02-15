import 'package:block_em_up/models/data_model.dart';
// import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String dbCreateQuery = "CREATE TABLE BlockedNumbers(id INTEGER PRIMARY KEY AUTOINCREMENT, blockingPattern TEXT, isBlockingActive INTEGER, dateCreated TEXT, dateModified TEXT)";
final String dbName = "blocked_numbers_database.db";

final Future<Database> database = getDatabasesPath().then((String path) => 
  openDatabase(join(path, dbName), onCreate: (db, version) {
    return db.execute(dbCreateQuery);
  })
);

class DataService {
  static Database _db;
  Database db1;

  DataService() {
    this.open();
  }

  Future open() async {
    if (this.db1 != null) {
      return;
    }
    
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "blocked_numbers_database.db");
    this.db1 = await openDatabase(path, version: 1,
      onCreate: (Database db2, int version) async {
        await db2.execute(dbCreateQuery);
      }
    );
  }

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    // Get a location using path_provider
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "blocked_numbers_database.db");

    // await deleteDatabase(path);
    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          print('creating db...');

        return db.execute(
          "CREATE TABLE BlockedNumbers(id INTEGER PRIMARY KEY AUTOINCREMENT, blockingPattern TEXT, isBlockingActive INTEGER, dateCreated TEXT, dateModified TEXT)"
        );

      // String sql = await rootBundle.loadString('assets/db/schema.txt');
      // for (var s in sql.split(";")) {
      //   if (s.length > 5) {
      //     // catching any hidden characters at end of schema
      //     await db.execute(s + ';');
      //   }
      // }
      // When creating the db, create the table
    });

    return theDb;
  }

  // final Future<Database> database = getDatabasesPath().then((String path) => 
  //   openDatabase(join(path, 'blocked_numbers_database.db'), onCreate: (db, version) {
  //     return db.execute(
  //       "CREATE TABLE BlockedNumbers(id INTEGER PRIMARY KEY, blockingPattern TEXT, isBlockingActive INTEGER, dateCreated TEXT, dateModified TEXT"
  //       );
  //   })
  // );

  Future<List<Map<String, dynamic>>> getAllEntities<T>(String tableName) async {
    await this.open();
    var data = await this.db1.query(tableName);
    return data;
  }

  Future<void> insert(DataEntity dataEntity, String tableName) async {
    // final Database db = await database;
    await this.db1.insert(tableName, dataEntity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
