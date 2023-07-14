import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishwell/main.dart';
//import 'package:wishwell/main.dart';
import 'package:wishwell/pdf/pdfview_will.dart';
import 'package:wishwell/provider/user_provider.dart';
import 'package:wishwell/user_add.dart';
import '../home_screen.dart';

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
    'My Details',
    'Executor 1',
    'Executor 2',
    'Guardian 1',
    'Guardian 2',
    'Age of Trust',
    'Simultaneous Clause',
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
    _future = Provider.of<WillProvider>(context, listen: false).selectData();
    super.initState();
  }

  bool showBottomMenu = false;
  late final Future _future;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Consumer<WillProvider>(
              builder: (context, willProvider, child) {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "My wishes",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Container(
                                  width: 10,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserAdd()));
                                  },
                                  child: const Text(
                                    'Edit',
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PdfPreviewWillPage(
                                                pageFormat: PdfPageFormat.a4,
                                                pdf: willProvider,
                                                metaTitle:
                                                    'Preview: My wishes'),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.picture_as_pdf,
                                    color: ColorConstants.primaryAppColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       left: 20, right: 20, bottom: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         'You have nearly completed your wishes',
                          //         style: Theme.of(context).textTheme.bodyMedium,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),

                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     textAlign: TextAlign.center,
                          //     maxLines: 4,
                          //     overflow: TextOverflow.ellipsis,
                          //     "Complete the sections below.",
                          //     style: TextStyle(fontSize: 15),
                          //   ),
                          // ),

                          Expanded(
                            child: Container(
                              color: Colors.grey.shade200,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.all(20.0),
                                    //   child: Text(
                                    //     "DONE",
                                    //     style: TextStyle(
                                    //       fontFamily: 'Inter',
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w800,
                                    //       color: Colors.grey.shade600,
                                    //     ),
                                    //     textAlign: TextAlign.center,
                                    //   ),
                                    // ),
                                    const SizedBox(height: 5),
                                    ...invalidList.map((e) => InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => UserAdd(
                                                index: e.keys.first,
                                              ),
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 20),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height: 41,
                                                    width: 31,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                    )),
                                                const SizedBox(width: 10),
                                                Text(
                                                  e.values.first,
                                                  style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 17,
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                    // const SizedBox(
                                    //   height: 40,
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(20.0),
                                    //   child: Text(
                                    //     "TO DO",
                                    //     style: TextStyle(
                                    //       fontFamily: 'Inter',
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w800,
                                    //       color: Colors.grey.shade600,
                                    //     ),
                                    //     textAlign: TextAlign.center,
                                    //   ),
                                    // ),
                                    const SizedBox(height: 5),
                                    ...validList.map(
                                      (e) => InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => UserAdd(
                                              index: e.keys.first,
                                            ),
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 41,
                                                width: 31,
                                                decoration: const BoxDecoration(
                                                  //border: Border.all(),
                                                  shape: BoxShape.circle,
                                                  color: Color.fromARGB(
                                                      255, 108, 142, 235),
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                e.values.first,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(width: 5),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 17,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                //showBottomMenu = !showBottomMenu;
                                showBottomMenu = true;
                                debugPrint('Open the Drawer');
                              });
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 30,
                                  ),
                                  Text(
                                    "View PDF templates",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                    if (showBottomMenu)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showBottomMenu = false;
                          });
                        },
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: 1,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child:
                                Container(color: Colors.black.withOpacity(0.2)),
                          ),
                        ),
                      ),
                    AnimatedPositioned(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200),
                      left: 0,
                      bottom: (showBottomMenu) ? 0 : -(height / 1.7),
                      child: DrawerWidget(
                        isOpen: showBottomMenu,
                        metaTitle: '',
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
