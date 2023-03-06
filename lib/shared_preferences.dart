import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static Future saveJsonData(jsonData) async {
    // Device data
    final prefs = await SharedPreferences.getInstance();
    // Local empty data
    final String res = await rootBundle.loadString('assets/user_data.json');
    final userData = await json.decode(res);
    final rawData = userData['deets'];
    // SAVE VALUES TO DETAILS OBJECT
    rawData.addEntries(jsonData.entries);
    // THEN SAVE DETAILS OBJECT TO DEVICE PREFERENCES
    var savedData = jsonEncode(rawData);
    await prefs.setString('jsonData', savedData);
    debugPrint('In shared prefs some data has been saved to the device');
    debugPrint(savedData.toString());
  }

  // NOT USED
  static getJsonData() async {
    // Device data
    final prefs = await SharedPreferences.getInstance();
    // Local dummy data
    final String res = await rootBundle.loadString('assets/user_data.json');
    final userData = await json.decode(res);
    final defaultData = userData['deets_default'];
    // GET DEVICE DATA OR IF EMPTY GET SOME DUMMY DATA
    var temp = prefs.getString('jsonData') ?? jsonEncode(defaultData);
    return temp;
  }

  static getStartingData() async {
    // Device data
    final prefs = await SharedPreferences.getInstance();
    // Local dummy data
    final String res = await rootBundle.loadString('assets/user_data.json');
    final userData = await json.decode(res);
    final defaultData = userData['deets_default'];
    // GET DEVICE DATA OR IF EMPTY GET SOME DUMMY DATA
    var temp = prefs.getString('jsonData') ?? jsonEncode(defaultData);
    //debugPrint('Sharesy prefs: Grabbed starting data: $temp');
    return temp;
  }

  static getNewStartingData() async {
    // Device data
    final prefs = await SharedPreferences.getInstance();
    // Local dummy data
    final String res = await rootBundle.loadString('assets/user_data.json');
    final userData = await json.decode(res);
    final defaultData = userData['deets_default'];
    // GET DEVICE DATA OR IF EMPTY GET SOME DUMMY DATA
    var tempy = prefs.getString('jsonData') ?? jsonEncode(defaultData);
    //debugPrint('Shares prefs: Grabbed starting data: $tempy');
    return tempy;
  }
}
