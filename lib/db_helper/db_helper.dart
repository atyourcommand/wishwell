import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../client_model.dart';
import '../user_detail_model.dart';

class DBHelper {
  static const clients = 'clients';
  static const shares = 'shares';
  static const will = 'will';

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

  static Future<Database> willData() async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'will.db'),
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $will (
            shareId TEXT PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            dob TEXT,
            gender TEXT,
            city TEXT,
            country TEXT,
            executorFirstName TEXT,
            executorLastName TEXT,
            executorAddress1 TEXT,
            executorAddress2 TEXT,
            executorCity TEXT,
            executorCountry TEXT,
            executor2FirstName TEXT,
            executor2LastName TEXT,
            executor2Address1 TEXT,
            executor2Address2 TEXT,
            executor2City TEXT,
            executor2Country TEXT,
            guardianFirstName TEXT,
            guardianLastName TEXT,
            guardianAddress1 TEXT,
            guardianAddress2 TEXT,
            guardianCity TEXT,
            guardianCountry TEXT,
            guardian2FirstName TEXT,
            guardian2LastName TEXT,
            guardian2Address1 TEXT,
            guardian2Address2 TEXT,
            guardian2City TEXT,
            guardian2Country TEXT,
            ageOfTrust TEXT,
            days TEXT,
            isCremation TEXT,
            ashesWish TEXT,
            burialWish TEXT
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

  static Future<List<Map<String, dynamic>>> selectUsers(String table) async {
    final db = await DBHelper.willData();

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

  static Future insertUsers(String table, Map<String, Object> data) async {
    final db = await DBHelper.willData();
    log("deleting=====");
    await db.rawDelete("DELETE FROM $will");
    log("deleting SSSS=====");
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
    final db = await DBHelper.willData();
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
    debugPrint("games in display method $maps");

    return null;
  }

  Future<User?> displayUsers() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('shares');
    debugPrint("games in display method $maps");

    return null;
  }
}
