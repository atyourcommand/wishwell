//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:wishwell/client_model.dart';
//import 'package:wishwell/shared_preferences.dart';
//import 'package:wishwell/client_detail.dart';
//import 'components/nav2.dart';

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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(
                    height: 50,
                  ),
                  Text("Assets",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                      )),
                  // OutlinedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const Nav2()));
                  //   },
                  //   child: const Text('+ Client'),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
