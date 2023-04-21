import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../client_model.dart';

class DBHelper {
  static const clients = 'clients';
  static const shares = 'shares';

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
          "dob TEXT)",
        );
        // await db.execute(
        //     "CREATE TABLE IF NOT EXISTS $shares(clientId TEXT PRIMARY KEY,"
        //     "firstName TEXT,"
        //     "lastName TEXT,");
      },
      version: 2,
    ).then((value) {
      log("table created $value");
      return value;
    });
  }

  static Future<Database> databaseAssets() async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'shares.db'),
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $shares (
            shareId TEXT PRIMARY KEY,
            assetType TEXT,
            assetName TEXT,
            value NUMBER,
            share TEXT
            );
            ''');
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

  static Future<List<Map<String, dynamic>>> selectAssets(String table) async {
    final db = await DBHelper.databaseAssets();
    //without query

    final query = await db.query(table);

    return query;
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

  static Future insertAssets(String table, Map<String, Object> data) async {
    final db = await DBHelper.databaseAssets();

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

  static Future updateAsset(
    Map<String, Object> value,
    String id,
  ) async {
    final db = await DBHelper.databaseAssets();
    return db.update(
      "shares",
      value,
      where: 'shareId = ?',
      whereArgs: [id],
    );
  }

  static Future updateAssets(
    String tableName,
    String columnName,
    String value,
    String id,
  ) async {
    final db = await DBHelper.databaseAssets();
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

  static Future deleteByIdAssets(
    String tableName,
    String columnName,
    String id,
  ) async {
    final db = await DBHelper.databaseAssets();

    return db.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }

  Future<Client?> display() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('client');
    debugPrint("games in display method $maps");

    return null;
  }

  Future<Client?> displayAssets() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('shares');
    print("games in display method $maps");

    return null;
  }
}
