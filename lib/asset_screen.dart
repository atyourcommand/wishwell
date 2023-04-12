//import 'dart:convert';

//import 'dart:convert';

//import 'dart:convert';

import 'package:flutter/material.dart';

class Assets {
  String? id;
  String? name;
  List<Shares>? shares;

  Assets({this.id, this.name, this.shares});

  Assets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['shares'] != null) {
      shares = <Shares>[];
      json['shares'].forEach((v) {
        shares!.add(Shares.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (shares != null) {
      data['shares'] = shares!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shares {
  String? clientId;
  int? clientShare;

  Shares({this.clientId, this.clientShare});

  Shares.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    clientShare = json['clientShare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['clientShare'] = clientShare;
    return data;
  }
}

var jsonData = {
  "asset": [
    {
      "id": "001",
      "type": "property",
      "name": "asset name 1",
      "value": "",
      "shares": [
        {"clientId": "1", "clientShare": 20},
        {"clientId": "2", "clientShare": 40}
      ],
      "sole": false
    },
    {
      "id": "002",
      "type": "cash",
      "name": "asset name 2",
      "value": "",
      "shares": [],
      "sole": true
    },
    {
      "id": "003",
      "type": "shares",
      "name": "asset name 3",
      "value": "",
      "shares": [],
      "sole": false
    },
    {
      "id": "004",
      "type": "posession",
      "name": "asset name 4",
      "value": "",
      "shares": [
        {"clientId": "1", "clientShare": 50},
        {"clientId": "2", "clientShare": 50}
      ],
      "sole": false
    }
  ]
}; // your json as string

//final Data _data = Data.fromJson(jsonData);

class Data {
  List<Assets>? asset;

  Data({this.asset});

  Data.fromJson(Map<String, dynamic> json) {
    if (jsonData['asset'] != null) {
      asset = <Assets>[];
      json['asset'].forEach((v) {
        asset!.add(Assets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (asset != null) {
      data['asset'] = asset!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssetScreen extends StatefulWidget {
  const AssetScreen({Key? key}) : super(key: key);

  @override
  State<AssetScreen> createState() => AssetScreenState();
}

class AssetScreenState extends State<AssetScreen> {
  @override
  void initState() {
    // clientList = clientData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber,
            //child: Center(child: Text('Asset: ${_data['']}')),
          );
        });
  }
}
