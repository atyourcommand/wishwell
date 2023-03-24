import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishwell/client_model.dart';

class AllData {
  static List<Client> clientList = [];
  static Future saveJsonData(objData) async {
    // PREFS DATA
    final prefs = await SharedPreferences.getInstance();
    // var currentPrefs = prefs.setString('jsonData', objData);
    // LOCAL DATA NOT USING
    // final String res = await rootBundle.loadString('assets/data.json');
    //final localData = await json.decode(res);
    // var rawData = await json.decode(currentPrefs!);
    // //debugPrint('SHOWING LOCAL DATA BEFORE SAVE: $rawData');
    // rawData.addEntries(objData.entries);
    // var savedData = jsonEncode(rawData);
    // //debugPrint('SHOWING LOCAL DATA AFTER SAVE: $savedData');
    // //await prefs.clear();
    // debugPrint("temp data====> $savedData");

    final body = objData;
    var clientData = body['clients'];
    clientList.add(Client(
        firstName: clientData['firstName'],
        lastName: clientData['lastName'],
        clientId: clientData['clientId'],
        address1: clientData['address1'],
        address2: clientData['address2'],
        city: clientData['city'],
        postcode: clientData['postcode'],
        country: clientData['country']));

    debugPrint("objData===> ${clientList}");
    await prefs.setString('jsonData', jsonEncode(clientList));
  }

  static Future<List<Client>> getClientData(BuildContext context) async {
    //final prefs = await SharedPreferences.getInstance();
    //var currentPrefs = prefs.getString('jsonData');
    // var rawData = await json.decode(currentPrefs!);
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/data.json');
    final body = await json.decode(data);
    var clientData = body['clients'];
    return clientData.map<Client>(Client.fromJson).toList();
  }

  static Future<dynamic> getStartingData() async {
    // Device data
    final prefs = await SharedPreferences.getInstance();
    // Local dummy data
    final String res = await rootBundle.loadString('assets/data.json');
    final theData = await json.decode(res);
    //final userData = theData['deets_default'];
    final userData = theData;
    // GET DEVICE DATA OR IF EMPTY GET SOME DUMMY DATA
    var temp = prefs.getString('jsonData') ?? jsonEncode(userData);
    debugPrint('THE STARTING DATA TO USE:$temp');
    return temp;
  }
}
