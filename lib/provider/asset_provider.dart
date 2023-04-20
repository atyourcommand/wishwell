import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wishwell/client_model.dart';

import '../db_helper/db_helper.dart';

class AssetsProvider extends ChangeNotifier {
  List<Assets> clienAssets = [];

  Future<void> selectAsset() async {
    final dataList = await DBHelper.selectAssets(DBHelper.shares);

    final assets = dataList.map((item) {
      List<Share> _shares = [];
      final shares = jsonDecode(item['share']) as List<dynamic>;
      for (var element in shares) {
        _shares.add(Share.fromJson(element));
      }
      log(_shares.toString());

      final asset = Assets(
          value: double.parse(item['value'].toString()),
          id: item['shareId'],
          shares: _shares,
          assetsType: item['assetType'],
          assetsName: item['assetName']);
      return asset;
    }).toList();
    clienAssets = assets;

    notifyListeners();
  }

  Future insertAssets(String firstName, String lastName, double value,
      List<Share> shares) async {
    final newAsset = Assets(
      id: const Uuid().v4(),
      shares: shares,
      value: value,
      assetsType: firstName,
      assetsName: lastName,
    );
    clienAssets.add(newAsset);

    DBHelper.insertAssets(DBHelper.shares, newAsset.toJson());
    notifyListeners();
  }

  Future deleteByIdAssets(shareId) async {
    DBHelper.deleteByIdAssets(
      DBHelper.shares,
      'shareId',
      shareId,
    );
    notifyListeners();
  }

  Future updateFirstNameAssets(String clientId, String firstName) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'firstName',
      firstName,
      clientId,
    );
    notifyListeners();
  }

  Future updateLastNameAssets(String clientId, String lastName) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'lastName',
      lastName,
      clientId,
    );
    notifyListeners();
  }

  Future updateAddress1Assets(String clientId, String address1) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'address1',
      address1,
      clientId,
    );
    notifyListeners();
  }

  Future updateAddress2Assets(String clientId, String address2) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'address2',
      address2,
      clientId,
    );
    notifyListeners();
  }

  Future updateCityAssets(String clientId, String city) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'city',
      city,
      clientId,
    );
    notifyListeners();
  }

  Future updateCountryAssets(String clientId, String country) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'country',
      country,
      clientId,
    );
    notifyListeners();
  }

  Future updateDobAssets(String clientId, String dob) async {
    DBHelper.updateAssets(
      DBHelper.clients,
      'dob',
      dob,
      clientId,
    );
    notifyListeners();
  }
}
