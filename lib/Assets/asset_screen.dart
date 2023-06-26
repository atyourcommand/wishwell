//import 'dart:convert';

//import 'dart:convert';

//import 'dart:convert';

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/provider/asset_provider.dart';
//import 'package:wishwell/provider/client_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

//import '../components/nav2.dart';
//import '../pdf/pdf.dart';
// ignore: unused_import
import '../home_screen.dart';
import '../pdf/detail_page.dart';
import '../utils/enums.dart';
import 'add_assets.dart';
import 'assets_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool showBottomMenu = false;
  @override
  void initState() {
    // clientList = clientData;
    _futer = Provider.of<AssetsProvider>(context, listen: false).selectAsset();
    super.initState();
  }

  late final Future _futer;

  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  final formatCurrency = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Assets",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          //fontStyle: FontStyle.normal,
                          fontFamily: 'Inter-Light',
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AssetsAdd(),
                            ),
                          );
                        },
                        child: const Text('+ Add'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey.shade200,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                          future: _futer,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Consumer<AssetsProvider>(
                                  builder: (context, assetProvider, child) {
                                return assetProvider.clienAssets.isNotEmpty
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                            assetProvider.clienAssets.length,
                                        itemBuilder: (context, index) {
                                          double totalPercentage = 0;

                                          for (var element in assetProvider
                                              .clienAssets[index].shares) {
                                            totalPercentage +=
                                                element.shareValue;
                                          }
                                          log(assetProvider.clienAssets.length);

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: .0,
                                              top: 0.0,
                                            ),
                                            child: Card(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                side: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              child: ListTile(
                                                //dense: true,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  top: 10.0,
                                                  bottom: 10.0,
                                                  left: 10.0,
                                                  right: 10.0,
                                                ),

                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 6.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const <Widget>[
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color.fromARGB(
                                                            255, 108, 142, 235),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //LASTEST VERSION
                                                leading: Container(
                                                  height: 46,
                                                  width: 46,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(
                                                        255, 108, 142, 235),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    FontAwesomeIcons.user,
                                                    size: 20, //Icon Size
                                                    color: Colors
                                                        .white, //Color Of Icon
                                                  ),
                                                ),

                                                //NEXT VERSION
                                                // leading: CircleAvatar(
                                                //   backgroundColor:
                                                //       const Color.fromARGB(
                                                //           255, 108, 142, 235),
                                                //   radius: 25,
                                                //   backgroundImage: NetworkImage(
                                                //       mapOfAssetType[assetProvider
                                                //                   .clienAssets[
                                                //                       index]
                                                //                   .assetsType]
                                                //               ?.imagePath ??
                                                //           ''),
                                                // ),
                                                //ORIGINAL VERSION
                                                // leading: Image.network(
                                                //   mapOfAssetType[assetProvider
                                                //               .clienAssets[index]
                                                //               .assetsType]
                                                //           ?.imagePath ??
                                                //       '',
                                                //   scale: 4.5,
                                                // ),

                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      assetProvider
                                                          .clienAssets[index]
                                                          .assetsName,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Inter-Light',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    // LETS HIDE VALUE ATM
                                                    // Text(
                                                    //   "${formatCurrency.format(assetProvider.clienAssets[index].value).toString().replaceAll(regex, '')}*",
                                                    //   maxLines: 3,
                                                    //   overflow:
                                                    //       TextOverflow.ellipsis,
                                                    //   style: const TextStyle(
                                                    //     fontSize: 13,
                                                    //     fontWeight:
                                                    //         FontWeight.normal,
                                                    //     color: Colors.grey,
                                                    //   ),
                                                    // ),

                                                    // print(
                                                    //     "${assetProvider.clienAssets[index].value.toString().replaceAll(regex, '')}");
                                                    RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              //"${totalPercentage.toString().replaceAll(regex, '')}% Shared by ${assetProvider.clienAssets[index].shares.length} persons",
                                                              "Shared by ${assetProvider.clienAssets[index].shares.length} persons",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Inter-Light',
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        //SHOW A MESSAGE IF % IS LESS THAN 100
                                                        // totalPercentage < 100
                                                        //     ? TextSpan(
                                                        //         text:
                                                        //             "${(100 - totalPercentage).toString().replaceAll(regex, '')}% unallocated",
                                                        //         style:
                                                        //             const TextStyle(
                                                        //           color:
                                                        //               Colors.grey,
                                                        //         ),
                                                        //       )
                                                        //     : const TextSpan(),
                                                      ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                                    LinearPercentIndicator(
                                                      animation: true,
                                                      animationDuration: 800,
                                                      width: 190.0,
                                                      lineHeight: 20.0,
                                                      percent:
                                                          (totalPercentage /
                                                              100),
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      progressColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              108,
                                                              142,
                                                              235),
                                                      trailing: Icon(
                                                        totalPercentage == 100
                                                            ? Icons.mood
                                                            : Icons.mood_bad,
                                                      ),
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      center: Text(
                                                        "$totalPercentage% allocated",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssetsPage(
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
                      ]),
                    ),
                  ),
                  // buildClients(clientList),
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //           MaterialPageRoute(builder: (context) => PdfView()));
                  //     },
                  //     child: Text("PDF"))
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showBottomMenu = !showBottomMenu;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 30,
                        ),
                        Text(
                          " View PDF templates",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (showBottomMenu)
              GestureDetector(
                onTap: () {
                  setState(() {
                    showBottomMenu = false;
                  });
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: 1,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(color: Colors.black.withOpacity(0.2)),
                  ),
                ),
              ),
            AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 200),
              left: 0,
              bottom: (showBottomMenu) ? 0 : -(height / 2),
              child: DrawerWidget(isOpen: showBottomMenu),
            ),
          ],
        ),
      ),
    );
  }
}
