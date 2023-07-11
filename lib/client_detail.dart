//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//import 'package:wishwell/Assets/asset_screen.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/edit_client.dart';
import 'package:wishwell/main.dart';
import 'package:wishwell/provider/asset_provider.dart';
import 'package:wishwell/provider/client_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Assets/assets_detail.dart';
//import 'Assets/assets_model.dart';

class ClientPage extends StatefulWidget {
  final Client client;

  final AssetsProvider assetsProvider;

  const ClientPage({
    Key? key,
    required this.client,
    required this.assetsProvider,
  }) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final clientAssets = [];
  void getAssetsDetails() {
    for (var element in widget.assetsProvider.clienAssets) {
      for (var share in element.shares) {
        if (share.clientName == widget.client.firstName) {
          clientAssets.add({
            'asset': element,
            'assetName': element.assetsName,
            'type': element.assetsType,
            'share': share.shareValue,
            'value': element.value * share.shareValue / 100
          });
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getAssetsDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Beneficiary',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClientEdit(
                    clientId: widget.client.clientId,
                    firstName: widget.client.firstName,
                    lastName: widget.client.lastName,
                    gender: widget.client.gender,
                    address1: widget.client.address1,
                    address2: widget.client.address2,
                    city: widget.client.city,
                    country: widget.client.country,
                    dob: widget.client.dob,
                  ),
                ));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.grey.shade200,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  // Icon(
                  //   Icons.account_circle_outlined,
                  //   color: Colors.grey.shade400,
                  //   size: 80,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${widget.client.firstName} ${widget.client.lastName}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10),
                    child: Center(
                      child: Text(
                        '${widget.client.gender}, ${widget.client.dob}\n${widget.client.address1} ${widget.client.address2} ${widget.client.city} \n${widget.client.country},',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clientAssets.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            bottom: 0.0,
                            top: 0.0,
                          ),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AssetsPage(
                                              totalPercentage:
                                                  clientAssets[index]['share'],
                                              asset: clientAssets[index]
                                                  ['asset'],
                                            )));
                              },
                              contentPadding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 15.0,
                                right: 10.0,
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.arrow_forward_ios,
                                        color: ColorConstants.primaryAppColor),
                                  ],
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${clientAssets[index]['assetName'].toString()} ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${formatCurrency.format(clientAssets[index]['value']).toString()} (${clientAssets[index]['type'].toString()})',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              leading: Container(
                                height: 46,
                                width: 46,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 108, 142, 235),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  FontAwesomeIcons.cashRegister,
                                  size: 20, //Icon Size
                                  color: Colors.white, //Color Of Icon
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 30),
                  OutlinedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          scrollable: true,
                          title: const Text('Delete'),
                          content: const Text('Do You Want to delete it ?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ClientProvider>()
                                    .deleteById(widget.client.clientId);
                                context
                                    .read<ClientProvider>()
                                    .clientItem
                                    .remove(widget.client);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Client deleted'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                      // AllData.deleteClient('1');
                    },
                    child: const Text('Delete this beneficiary'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
