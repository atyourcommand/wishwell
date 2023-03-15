import 'package:flutter/material.dart';
import 'package:wishwell/client_model.dart';

import 'package:flutter/cupertino.dart';

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
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                client.lastName,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CupertinoButton.filled(
                onPressed: () {},
                child: const Text('Connect'),
              ),
            ],
          ),
        ),
      );
}
