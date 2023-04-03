import 'package:flutter/material.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/shared_preferences.dart';
//import 'package:flutter/cupertino.dart';

class ClientPage extends StatelessWidget {
  final Client client;

  const ClientPage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(client.firstName,
              style: const TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
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
              Text(
                client.dob,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                client.gender,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
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
                client.postcode,
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
                  AllData.deleteClient(int.parse(client.clientId));
                },
                child: const Text('Deleted this client'),
              )
            ],
          ),
        ),
      );
}
