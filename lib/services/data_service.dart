import 'package:block_em_up/models/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final Future<Database> database = getDatabasesPath().then((String path) => 
  openDatabase(join(path, 'blocked_numbers_database.db'), onCreate: (db, version) {
    return db.execute(
      "CREATE TABLE BlockedNumbers(id INTEGER PRIMARY KEY, blockingPattern TEXT, isBlockingActive INTEGER, dateCreated TEXT, dateModified TEXT"
      );
  })
);

Future<void> insert(DataEntity dataEntity, String tableName) async {
  final Database db = await database;
  await db.insert('table', dataEntity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}
