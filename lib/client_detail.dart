import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/edit_client.dart';
import 'package:wishwell/provider/client_provider.dart';

class ClientPage extends StatelessWidget {
  final Client client;

  const ClientPage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(client.firstName),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
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
                  ));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Image.network(
              //  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
              //  height: 400,
              // width: double.infinity,
              //  fit: BoxFit.cover,
              //),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${client.firstName} ${client.lastName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                client.gender,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                client.dob,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                client.address1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                client.address2,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                client.city,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                client.country,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),

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
                child: const Text('Deleted this client'),
              )
            ],
          ),
        ),
      );
}
