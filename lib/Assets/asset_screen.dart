//import 'dart:convert';

//import 'dart:convert';

//import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/provider/asset_provider.dart';
//import 'package:wishwell/provider/client_provider.dart';

//import '../components/nav2.dart';
//import '../pdf/pdf.dart';
import '../utils/enums.dart';
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

  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  final formatCurrency = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Assets",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AssetsAdd()));
                    },
                    child: const Text('+ Add assets'),
                  ),
                  // OutlinedButton(
                  //     onPressed: () {},
                  //     child: const Text(
                  //       "preview",
                  //       style: TextStyle(),
                  //     ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<AssetsProvider>(context, listen: false)
                      .selectAsset(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer<AssetsProvider>(
                          builder: (context, assetProvider, child) {
                        return assetProvider.clienAssets.isNotEmpty
                            ? ListView.builder(
                                itemCount: assetProvider.clienAssets.length,
                                itemBuilder: (context, index) {
                                  double totalPercentage = 0;
                                  for (var element in assetProvider
                                      .clienAssets[index].shares) {
                                    totalPercentage += element.shareValue;
                                  }
                                  log(assetProvider.clienAssets.length);

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 5,
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
                                          left: 5,
                                          right: 2,
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black26,
                                        ),
                                        leading: Image.network(
                                          mapOfAssetType[assetProvider
                                                      .clienAssets[index]
                                                      .assetsType]
                                                  ?.imagePath ??
                                              '',
                                          scale: 4.5,
                                        ),

                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              assetProvider.clienAssets[index]
                                                  .assetsName,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Total approximate value: ${formatCurrency.format(assetProvider.clienAssets[index].value).toString().replaceAll(regex, '')}",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),

                                            // print(
                                            //     "${assetProvider.clienAssets[index].value.toString().replaceAll(regex, '')}");
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      "${totalPercentage.toString().replaceAll(regex, '')}% shared to ${assetProvider.clienAssets[index].shares.length} person",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                totalPercentage < 100
                                                    ? TextSpan(
                                                        text:
                                                            "  ${(100 - totalPercentage).toString().replaceAll(regex, '')}% unallocated",
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    : const TextSpan(),
                                              ]),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => AssetsPage(
                                              asset: assetProvider
                                                  .clienAssets[index],
                                            ),
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
              ),
              // buildClients(clientList),
              // TextButton(
              //     onPressed: () {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context) => PdfView()));
              //     },
              //     child: Text("PDF"))
            ],
          ),
        ),
      ),
    );
  }
}
