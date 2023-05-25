import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishwell/provider/user_provider.dart';
import 'package:wishwell/user_add.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<bool> validationBools = [];
  List<Map<int, String>> validList = [];
  List<Map<int, String>> invalidList = [];
  final listOfForms = [
    'My Detail',
    'Executor 1',
    'Executor 2',
    'Guardian 1',
    'Guardian 2',
    'Age of Trust',
    'Silmultaneous Clause',
    'Burial/Cremation Wishes',
  ];
  getValidationBools() async {
    final prefs = await SharedPreferences.getInstance();
    final dataList = prefs.getStringList('validationBools') ?? [];
    setState(() {
      validationBools = dataList.map<bool>((e) => jsonDecode(e)).toList();
    });
    for (var i = 0; i < validationBools.length; i++) {
      if (validationBools[i]) {
        validList.add({i: listOfForms[i]});
      } else {
        invalidList.add({i: listOfForms[i]});
      }
    }
  }

  @override
  void initState() {
     context.read<WillProvider>().selectData();
    getValidationBools();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "My wishes",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserAdd()));
                  },
                  child: const Text('Edit my wishes'),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    "Prepering and perinting a beautiful formatted copy of youre last wishes, assets and beneficiaries is easy. Complete the tasks below to preview your PDF.",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 20,
                        )),
                    const Text(
                      " Completed",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    )
                  ],
                ),
                ...validList.map(
                  (e) => TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserAdd(index: e.keys.first),
                      ));
                    },
                    child: Text(e.values.first),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 25,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.rule,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const Text(
                      " Incompleted/needs attention",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    )
                  ],
                ),
                ...invalidList.map((e) => TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserAdd(index: e.keys.first),
                        ));
                      },
                      child: Text(e.values.first),
                    )),
                // Flexible(
                //   child: ListView.builder(
                //       itemCount: invalidList.length,
                //       itemBuilder: (context, index) {
                //         return TextButton(
                //           onPressed: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) =>
                //                   UserAdd(index: invalidList[index].keys.first),
                //             ));
                //           },
                //           child: Text(invalidList[index].values.first),
                //         );
                //       }),
                // ),
              ],
            ),
          ),
        ),
      );
}
