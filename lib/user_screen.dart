import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/provider/client_provider.dart';
import 'package:wishwell/user_add.dart';

import 'client_detail.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "User",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const UserAdd()));
                },
                child: const Text('+ Add another user to your Will'),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<ClientProvider>(context, listen: false)
                      .selectData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer<ClientProvider>(
                          builder: (context, clientProvider, child) {
                        return clientProvider.clientItem.isNotEmpty
                            ? ListView.builder(
                                itemCount: clientProvider.clientItem.length,
                                itemBuilder: (context, index) {
                                  return const Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        bottom: 1.0,
                                        top: 0.0),
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                        color: Colors.black12,
                                      )),
                                      child: ListTile(
                                          //dense: true,
                                          // contentPadding: const EdgeInsets.only(
                                          //     top: 10.0,
                                          //     bottom: 10.0,
                                          //     left: 10.0,
                                          //     right: 10.0),
                                          // trailing: const Icon(
                                          //   Icons.arrow_forward_ios,
                                          //   color: Colors.black26,
                                          // ),
                                          // leading: Icon(
                                          //   Icons.account_circle_outlined,
                                          //   color: Colors.grey.shade400,
                                          //   size: 45,
                                          // ),

                                          // title: Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(
                                          //       '${clientProvider.clientItem[index].firstName} ${clientProvider.clientItem[index].lastName}',
                                          //       style: const TextStyle(
                                          //         fontSize: 20,
                                          //         fontWeight: FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //     const SizedBox(
                                          //       height: 3,
                                          //     ),

                                          //     Row(
                                          //       children: const [
                                          //         Text(
                                          //           "Incomplete details",
                                          //           style: TextStyle(
                                          //               color: Colors.grey),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     Row(
                                          //       children: const [
                                          //         Text(
                                          //           "No assets allocated yet",
                                          //           style: TextStyle(
                                          //               color: Colors.grey),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     const Text(" Last Name :"),
                                          //     //     Text(clientProvider
                                          //     //         .clientItem[index]
                                          //     //         .lastName),
                                          //     //   ],
                                          //     // ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     const Text("city :"),
                                          //     //     Text(clientProvider
                                          //     //         .clientItem[index].city),
                                          //     //   ],
                                          //     // ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     const Text("address1 :"),
                                          //     //     Text(clientProvider
                                          //     //         .clientItem[index]
                                          //     //         .address1),
                                          //     //   ],
                                          //     // ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     const Text("address2 :"),
                                          //     //     Text(clientProvider
                                          //     //         .clientItem[index]
                                          //     //         .address2),
                                          //     //   ],
                                          //     // ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     const Text("country :"),
                                          //     //     Text(clientProvider
                                          //     //         .clientItem[index].country),
                                          //     //   ],
                                          //     // ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     const Text("postcode :"),
                                          //     //     Text(client.postcode),
                                          //     //   ],
                                          //     // ),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     Text("DOB :"),
                                          //     //     Text(client.dob),
                                          //     //   ],
                                          //     // ),
                                          //   ],
                                          // ),
                                          // onTap: () {
                                          //   Navigator.of(context)
                                          //       .push(MaterialPageRoute(
                                          //     builder: (context) => ClientPage(
                                          //         client: clientProvider
                                          //             .clientItem[index]),
                                          //   ));
                                          // },
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
            ],
          ),
        )),
      );
}
