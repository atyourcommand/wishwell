import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/edit_client.dart';
import 'package:wishwell/provider/asset_provider.dart';
import 'package:wishwell/provider/client_provider.dart';

import 'Assets/assets_detail.dart';
import 'Assets/assets_model.dart';

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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // title: Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       ///client.firstName,
          //       style: const TextStyle(color: Colors.black45),
          //     ),
          //   ],
          // ),
          centerTitle: true,
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey.shade400,
                  size: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.client.firstName} ${widget.client.lastName}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.client.gender,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  widget.client.dob,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  widget.client.address1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  widget.client.address2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  widget.client.city,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  widget.client.country,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: clientAssets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 0.0,
                          top: 0.0,
                        ),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AssetsPage(
                                            asset: clientAssets[index]['asset'],
                                          )));
                            },
                            contentPadding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 108, 142, 235),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  clientAssets[index]['type'].toString(),
                                ),
                                Text(
                                  clientAssets[index]['value'].toString(),
                                ),
                              ],
                            ),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  clientAssets[index]['assetName'],
                                ),
                              ],
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
                  child: const Text('Delete this person from your Will'),
                ),
                Container(
                  child: (const Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      bottom: 1.0,
                      top: 0.0,
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Add assets list view here',
                        ),
                      ),
                    ),
                  )),
                ),
              ]),
            ),
          ),
        ),
      );
}
