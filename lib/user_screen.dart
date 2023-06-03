import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:wishwell/pdf/pdfview_client.dart';
import 'package:wishwell/pdf/pdfview_will.dart';
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
    final dataList = prefs.getStringList('validationBools') ??
        List.generate(8, (index) => "false");
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
            child: FutureBuilder(
                future: Provider.of<WillProvider>(context, listen: false)
                    .selectData(),
                builder: (context, snapshot) {
                  return Consumer<WillProvider>(
                      builder: (context, willProvider, child) {
                    return SingleChildScrollView(
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
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PdfPreviewWillPage(pdf: willProvider),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.picture_as_pdf,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
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
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              )
                            ],
                          ),
                          ...validList.map(
                            (e) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserAdd(
                                    index: e.keys.first,
                                  ),
                                ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 30),
                                child: Row(
                                  children: [
                                    Text(
                                      e.values.first,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 19,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              )
                            ],
                          ),
                          ...invalidList.map((e) => InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserAdd(
                                      index: e.keys.first,
                                    ),
                                  ));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        e.values.first,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 19,
                                      )
                                    ],
                                  ),
                                ),
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
                    );
                  });
                }),
          ),
        ),
      );
}
