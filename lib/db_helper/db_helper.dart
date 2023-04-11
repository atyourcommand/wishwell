import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const clients = 'clients';

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'clients.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS $clients(clientId TEXT PRIMARY KEY,"
                "firstName TEXT,"
                "lastName TEXT,"
                "gender TEXT,"
                "address1 TEXT,"
                "address2 TEXT,"
                "city TEXT,"
                "country TEXT,"
                "dob TEXT)");
      },
      version: 2,
    ).then((value) {
      log("table created $value");
      return value;
    });
  }

  static Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final db = await DBHelper.database();
    //without query
    return db.query(table);
    // with query
    //return db.rawQuery("SELECT * FROM $clients");
  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future update(
      String tableName,
      String columnName,
      String value,
      String id,
      ) async {
    final db = await DBHelper.database();
    return db.update(
      tableName,
      {columnName: value},
      where: 'clientId = ?',
      whereArgs: [id],
    );
  }

  static Future deleteById(
      String tableName,
      String columnName,
      String id,
      ) async {
    final db = await DBHelper.database();

    return db.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }
}