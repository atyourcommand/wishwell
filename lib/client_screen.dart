//import 'dart:convert';
// ignore_for_file: prefer_typing_uninitialized_variables

//import 'dart:html';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
//import 'package:pdf/pdf.dart';
import 'package:wishwell/add_client.dart';
import 'package:wishwell/pdf/detail_page.dart';
//import 'package:wishwell/home_screen.dart';
import 'package:wishwell/pdf/pdfview_client.dart';
import 'package:wishwell/provider/asset_provider.dart';
//import 'package:wishwell/client_model.dart';
import 'package:wishwell/provider/client_provider.dart';
//import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/client_detail.dart';
//import 'components/nav2.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
//import 'package:wishwell/pdf/pdf_client.dart';

class ClientScreen extends StatefulWidget {
  //final ClientProvider clientDoc;
  const ClientScreen({
    Key? key,
    //required this.clientDoc,
  }) : super(key: key);

  @override
  State<ClientScreen> createState() => ClientScreenState();
}

class ClientScreenState extends State<ClientScreen> {
  var clientDoc;

  //List<Client> clientList = [];
  // final FormValidator formValidator = FormValidator();
  // final _formKey = GlobalKey<FormBuilderState>();
  // late TextEditingController _firstNameController;
  // late TextEditingController _lastNameController;
  // late TextEditingController _gender;
  // late TextEditingController _address1;
  // late TextEditingController _address2;
  // late TextEditingController _city;
  // late TextEditingController _country;
  // late TextEditingController _dob;
  // String? _dropDownValue;
  // late Future<List<Client>> clientsFuture; //NEW

  @override
  void initState() {
    // AllData.getStartingData().then((value) async {
    //   final body = await json.decode(value);
    //   List<dynamic> clientData = body["clients"];
    //   debugPrint("clientData==> ${clientData[0]['firstName']}");
    //   clientList.clear();
    //   setState(() {
    //     for (int i = 0; i < clientData.length; i++) {
    //       clientList.add(Client(
    //         firstName: clientData[i]['firstName'],
    //         lastName: clientData[i]['lastName'],
    //         clientId: clientData[i]['clientId'],
    //         gender: clientData[i]['gender'],
    //         address1: clientData[i]['address1'],
    //         address2: clientData[i]['address2'],
    //         city: clientData[i]['city'],
    //         dob: clientData[i]['dob'],
    //         //postcode: clientData[i]['postcode'],
    //         country: clientData[i]['country'],
    //       ));
    //     }
    //     // clientList = clientData;
    //   });

    //   debugPrint("value===> ${clientList.length}");
    // });
    _future = Future.wait([
      Provider.of<ClientProvider>(context, listen: false).selectData(),
      Provider.of<AssetsProvider>(context, listen: false).selectAsset(),
    ]);
    super.initState();
  }

  late final Future _future;
  bool showBottomMenu = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer2<ClientProvider, AssetsProvider>(builder:
                          (context, clientProvider, assetsProvider, child) {
                        return Column(
                          // ignore: prefer_const_literals_to_create_immutables
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
                                    "Beneficiaries",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      //fontStyle: FontStyle.normal,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const ClientAdd(),
                                        ),
                                      );
                                    },
                                    child: const Text('+Add'),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PdfPreviewClientPage(
                                            pageFormat: PdfPageFormat.a4,
                                            pdf: clientProvider,
                                            assets: assetsProvider,
                                          ),
                                        ),
                                      );
                                      // rootBundle.
                                    },
                                    child: const Icon(
                                      Icons.picture_as_pdf,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    '• 1 Beneficiary has no assets',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    '• 3 Assets are unallocated',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 25,
                            ),

                            Expanded(
                              child: Container(
                                color: Colors.grey.shade200,
                                child: clientProvider.clientItem.isNotEmpty
                                    ? ListView(
                                        children: [
                                          ListView.builder(
                                              physics: const ScrollPhysics(),
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              shrinkWrap: true,
                                              itemCount: clientProvider
                                                  .clientItem.length,
                                              itemBuilder: (context, index) {
                                                log("121210 ${clientProvider.clientItem.length}");
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    bottom: 0.0,
                                                    top: 0.0,
                                                  ),
                                                  child: Card(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      side: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
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
                                                      trailing: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color.fromARGB(
                                                            255, 108, 142, 235),
                                                      ),

                                                      leading:
                                                          const CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                108, 142, 235),
                                                        radius: 25,
                                                        child: Icon(
                                                          Icons
                                                              .person_4_rounded,
                                                          color: Colors.white,
                                                        ),
                                                      ),

                                                      title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${clientProvider.clientItem[index].firstName} ${clientProvider.clientItem[index].lastName}',
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          const Text(
                                                            "No assets yet",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              ClientPage(
                                                            client: clientProvider
                                                                    .clientItem[
                                                                index],
                                                            assetsProvider:
                                                                assetsProvider,
                                                          ),
                                                        ));
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      )
                                    : const Center(
                                        child: Text('No details found!!!'),
                                      ),
                              ),
                            ),
                            // buildClients(clientList),
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
                        );
                      });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
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
              child:  DrawerWidget(isOpen:showBottomMenu ),
            ),
          ],
        ),
      ),
    );
  }
}
