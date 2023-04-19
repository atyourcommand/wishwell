//import 'dart:convert';

//import 'dart:convert';

//import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/provider/client_provider.dart';

import 'add_assets.dart';
import 'assets_detail.dart';

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
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   child: SizedBox(
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const Nav2()));
      //       },
      //       child: const Text("Add another client"),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Assets",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  )),
              const SizedBox(
                height: 10,
              ),

              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AssetsAdd()));
                },
                child: const Text('+ Add assets'),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<ClientProvider>(context, listen: false)
                      .selectAsset(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer<ClientProvider>(
                          builder: (context, assetProvider, child) {
                        return assetProvider.clienAssets.isNotEmpty
                            ? ListView.builder(
                                itemCount: assetProvider.clienAssets.length,
                                itemBuilder: (context, index) {
                                  log(assetProvider.clienAssets.length);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      bottom: 1.0,
                                      top: 0.0,
                                    ),
                                    child: Card(
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      child: ListTile(
                                        //dense: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            left: 10.0,
                                            right: 10.0),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black26,
                                        ),
                                        leading: Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.grey.shade400,
                                          size: 45,
                                        ),

                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${assetProvider.clienAssets[index].firstName} ${assetProvider.clienAssets[index].lastName}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),

                                            Row(
                                              children: const [
                                                Text(
                                                  "Incomplete details",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  "No assets allocated yet",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Row(
                                            //   children: [
                                            //     const Text(" Last Name :"),
                                            //     Text(clientProvider
                                            //         .clientItem[index]
                                            //         .lastName),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text("city :"),
                                            //     Text(clientProvider
                                            //         .clientItem[index].city),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text("address1 :"),
                                            //     Text(clientProvider
                                            //         .clientItem[index]
                                            //         .address1),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text("address2 :"),
                                            //     Text(clientProvider
                                            //         .clientItem[index]
                                            //         .address2),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text("country :"),
                                            //     Text(clientProvider
                                            //         .clientItem[index].country),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     const Text("postcode :"),
                                            //     Text(client.postcode),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Text("DOB :"),
                                            //     Text(client.dob),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => AssetsPage(
                                                client: assetProvider
                                                    .clienAssets[index]),
                                          ));
                                        },
                                      ),
                                    ),
                                  );
                                })
                            : const Center(
                                child: Text('No details found!!!'),
                              );
                      });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
              // buildClients(clientList),
            ],
          ),
        ),
      ),
    );
  }
}
