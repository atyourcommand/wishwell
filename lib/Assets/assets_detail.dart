import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/edit_client.dart';
import 'package:wishwell/provider/client_provider.dart';

class AssetsPage extends StatelessWidget {
  final Assets client;

  const AssetsPage({
    Key? key,
    required this.client,
  }) : super(key: key);

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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClientEdit(
                        clientId: client.clientId,
                        firstName: client.firstName,
                        lastName: client.lastName,
                        gender: client.gender,
                        address1: client.address1,
                        address2: client.address2,
                        city: client.city,
                        country: client.country,
                        dob: client.dob,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: SizedBox.expand(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
                client.firstName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                client.lastName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              // Text(
              //   client.dob,
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
              // Text(
              //   client.address1,
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
              // Text(
              //   client.address2,
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
              // Text(
              //   client.city,
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
              // Text(
              //   client.country,
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
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
                                .deleteById(client.clientId);
                            context
                                .read<ClientProvider>()
                                .clientItem
                                .remove(client);
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
                        )
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
                    left: 15.0, right: 15.0, bottom: 1.0, top: 0.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                    color: Colors.black12,
                  )),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add assets list view here'),
                  ),
                ),
              ))),
            ]),
          ),
        ),
      );
}
