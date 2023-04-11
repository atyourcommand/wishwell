import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wishwell/client_model.dart';

import '../db_helper/db_helper.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> clientItem = [];

  Future<void> selectData() async {
    final dataList = await DBHelper.selectAll(DBHelper.clients);

    clientItem = dataList
        .map((item) => Client(
        clientId: item['clientId'],
        firstName: item['firstName'],
        lastName: item['lastName'],
        gender: item['gender'],
        address1: item['address1'],
        address2: item['address2'],
        city: item['city'],
        country: item['country'],
        dob: item['dob']))
        .toList();
  }

  Future insertData(
      String firstName,
      String lastName,
      String gender,
      String address1,
      String address2,
      String city,
      String country,
      String dob,
      ) async {
    final newClient = Client(
      clientId: const Uuid().v1(),
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      address1: address1,
      address2: address2,
      city: city,
      country: country,
      dob: dob,
    );
    clientItem.add(newClient);

    DBHelper.insert(DBHelper.clients, {
      'clientId': newClient.clientId,
      'firstName': newClient.firstName,
      'lastName': newClient.lastName,
      'gender': newClient.gender,
      'address1': newClient.address1,
      'address2': newClient.address2,
      'city': newClient.city,
      'country': newClient.country,
      'dob': newClient.dob,
    });
    notifyListeners();
  }

  Future deleteById(clientId) async {
    DBHelper.deleteById(
      DBHelper.clients,
      'clientId',
      clientId,
    );
    notifyListeners();
  }

  Future updateFirstName(String clientId, String firstName) async {
    DBHelper.update(
      DBHelper.clients,
      'firstName',
      firstName,
      clientId,
    );
    notifyListeners();
  }

  Future updateLastName(String clientId, String lastName) async {
    DBHelper.update(
      DBHelper.clients,
      'lastName',
      lastName,
      clientId,
    );
    notifyListeners();
  }

  Future updateGender(String clientId, String gender) async {
    DBHelper.update(
      DBHelper.clients,
      'gender',
      gender,
      clientId,
    );
    notifyListeners();
  }

  Future updateAddress1(String clientId, String address1) async {
    DBHelper.update(
      DBHelper.clients,
      'address1',
      address1,
      clientId,
    );
    notifyListeners();
  }

  Future updateAddress2(String clientId, String address2) async {
    DBHelper.update(
      DBHelper.clients,
      'address2',
      address2,
      clientId,
    );
    notifyListeners();
  }

  Future updateCity(String clientId, String city) async {
    DBHelper.update(
      DBHelper.clients,
      'city',
      city,
      clientId,
    );
    notifyListeners();
  }

  Future updateCountry(String clientId, String country) async {
    DBHelper.update(
      DBHelper.clients,
      'country',
      country,
      clientId,
    );
    notifyListeners();
  }

  Future updateDob(String clientId, String dob) async {
    DBHelper.update(
      DBHelper.clients,
      'dob',
      dob,
      clientId,
    );
    notifyListeners();
  }
}
