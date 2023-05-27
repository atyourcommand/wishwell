import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';
//import 'package:wishwell/client_model.dart';

import '../db_helper/db_helper.dart';
import '../user_detail_model.dart';

class WillProvider extends ChangeNotifier {
  List<User> userItem = [];

  Future<void> selectData() async {
    log("clientItem==>> ${userItem.length}");
    final dataList = await DBHelper.selectUsers(DBHelper.will);
    log("willl==>> $dataList");

    userItem = dataList
        .map((item) => User(
              firstName: item['firstName'],
              lastName: item['lastName'],
              dob: item['dob'],
              gender: item['gender'],
              city: item['city'],
              country: item['country'],
              executorFirstName: item['executorFirstName'],
              executorLastName: item['executorLastName'],
              executorAddress1: item['executorAddress1'],
              executorAddress2: item['executorAddress2'],
              executorCity: item['executorCity'],
              executorCountry: item['executorCountry'],
              executor2FirstName: item['executor2FirstName'],
              executor2LastName: item['executor2LastName'],
              executor2Address1: item['executor2Address1'],
              executor2Address2: item['executor2Address2'],
              executor2City: item['executor2City'],
              executor2Country: item['executor2Country'],
              guardianFirstName: item['guardianFirstName'],
              guardianLastName: item['guardianLastName'],
              guardianAddress1: item['guardianAddress1'],
              guardianAddress2: item['guardianAddress2'],
              guardianCity: item['guardianCity'],
              guardianCountry: item['guardianCountry'],
              guardian2FirstName: item['guardian2FirstName'],
              guardian2LastName: item['guardian2LastName'],
              guardian2Address1: item['guardian2Address1'],
              guardian2Address2: item['guardian2Address2'],
              guardian2City: item['guardian2City'],
              guardian2Country: item['guardian2Country'],
              ageOfTrust: item['ageOfTrust'],
              days: item['days'],
              isCremation: jsonDecode(item['isCremation']),
              ashesWish: item['ashesWish'],
              burialWish: item['burialWish'],
            ))
        .toList();
    notifyListeners();
    log("userItem== $userItem");
  }

  Future insertData(User user) async {
    final res = await DBHelper.insertUsers(DBHelper.will, {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'dob': user.dob,
      'gender': user.gender,
      'city': user.city,
      'country': user.country,
      'executorFirstName': user.executorFirstName,
      'executorLastName': user.executorLastName,
      'executorAddress1': user.executorAddress1,
      'executorAddress2': user.executorAddress2,
      'executorCity': user.executorCity,
      'executorCountry': user.executorCountry,
      'executor2FirstName': user.executor2FirstName,
      'executor2LastName': user.executor2LastName,
      'executor2Address1': user.executor2Address1,
      'executor2Address2': user.executor2Address2,
      'executor2City': user.executor2City,
      'executor2Country': user.executor2Country,
      'guardianFirstName': user.guardianFirstName,
      'guardianLastName': user.guardianLastName,
      'guardianAddress1': user.guardianAddress1,
      'guardianAddress2': user.guardianAddress2,
      'guardianCity': user.guardianCity,
      'guardianCountry': user.guardianCountry,
      'guardian2FirstName': user.guardian2FirstName,
      'guardian2LastName': user.guardian2LastName,
      'guardian2Address1': user.guardian2Address1,
      'guardian2Address2': user.guardian2Address2,
      'guardian2City': user.guardian2City,
      'guardian2Country': user.guardian2Country,
      'ageOfTrust': user.ageOfTrust,
      'days': user.days,
      'isCremation': user.isCremation.toString(),
      'ashesWish': user.ashesWish,
      'burialWish': user.burialWish,
    });
    debugPrint("dadfad $res");
    notifyListeners();
  }

  Future deleteById(clientId) async {
    DBHelper.deleteById(
      DBHelper.will,
      'clientId',
      clientId,
    );
    notifyListeners();
  }

  Future updateFirstName(String clientId, String firstName) async {
    DBHelper.update(
      DBHelper.will,
      'firstName',
      firstName,
      clientId,
    );
    notifyListeners();
  }

  Future updateLastName(String clientId, String lastName) async {
    DBHelper.update(
      DBHelper.will,
      'lastName',
      lastName,
      clientId,
    );
    notifyListeners();
  }

  Future updateGender(String clientId, String gender) async {
    DBHelper.update(
      DBHelper.will,
      'gender',
      gender,
      clientId,
    );
    notifyListeners();
  }

  Future updateAddress1(String clientId, String address1) async {
    DBHelper.update(
      DBHelper.will,
      'address1',
      address1,
      clientId,
    );
    notifyListeners();
  }

  Future updateAddress2(String clientId, String address2) async {
    DBHelper.update(
      DBHelper.will,
      'address2',
      address2,
      clientId,
    );
    notifyListeners();
  }

  Future updateCity(String clientId, String city) async {
    DBHelper.update(
      DBHelper.will,
      'city',
      city,
      clientId,
    );
    notifyListeners();
  }

  Future updateCountry(String clientId, String country) async {
    DBHelper.update(
      DBHelper.will,
      'country',
      country,
      clientId,
    );
    notifyListeners();
  }

  Future updateDob(String clientId, String dob) async {
    DBHelper.update(
      DBHelper.will,
      'dob',
      dob,
      clientId,
    );
    notifyListeners();
  }
}
