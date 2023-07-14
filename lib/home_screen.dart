import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/document_model.dart';
import 'package:provider/provider.dart';

import 'package:wishwell/provider/user_provider.dart';
//import 'package:wishwell/pdf/detail_page.dart';
import 'package:pdf/pdf.dart';
import 'package:wishwell/pdf/pdfview_will.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Client? client;

final docs = <Doc>[
  Doc(
    client: 'David Thomas',
    address: '123 Fake St\r\nBermuda Triangle',
    items: [
      LineItem(
        'Technical Engagement',
        120,
      ),
      LineItem('Deployment Assistance', 200),
      LineItem('Develop Software Solution', 3020.45),
      LineItem('Produce Documentation', 840.50),
    ],
    enabled: true,
    type: 'assets',
    name: 'Beneficiaries',
    description: 'All your assets and beneficiaries',
  ),
  Doc(
    client: 'Michael Ambiguous',
    address: '82 Unsure St\r\nBaggle Palace',
    items: [
      LineItem('Professional Advice', 100),
      LineItem('Lunch Bill', 43.55),
      LineItem('Remote Assistance', 50),
    ],
    enabled: true,
    type: 'will',
    name: 'Will Template A',
    description: 'A very simple Will',
  ),
  Doc(
    client: 'Marty McDanceFace',
    address: '55 Dancing Parade\r\nDance Place',
    items: [
      LineItem('Program the robots', 400.50),
      LineItem('Find tasteful dance moves for the robots', 80.55),
      LineItem('General quality assurance', 80),
    ],
    enabled: false,
    type: 'will',
    name: 'Will Template B',
    description: 'A smple Will with extra items',
  ),
  Doc(
    client: 'Marty McDanceFace',
    address: '55 Dancing Parade\r\nDance Place',
    items: [
      LineItem('Program the robots', 400.50),
      LineItem('Find tasteful dance moves for the robots', 80.55),
      LineItem('General quality assurance', 80),
    ],
    enabled: false,
    type: 'will',
    name: 'Will Template C',
    description: 'A simple Will with custom extra provisions',
  ),
];

class _HomeState extends State<Home> {
  bool showBottomMenu = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var threshold = 100;

    return Center(
      child: GestureDetector(
        onPanEnd: (details) {
          //debugPrint(details.velocity.pixelsPerSecond.toString())
          if (details.velocity.pixelsPerSecond.dy > threshold) {
            setState(() {
              showBottomMenu = false;
            });
          } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
            setState(() {
              showBottomMenu = true;
            });
          }
        },
        child: SizedBox(
          height: height,
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                color: Colors.black,
                height: (MediaQuery.of(context).size.height),
                width: (MediaQuery.of(context).size.width),
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: (MediaQuery.of(context).size.width),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://get.pxhere.com/photo/beach-sea-coast-ocean-architecture-house-town-vacation-travel-village-mediterranean-tower-seascape-bay-island-blue-chapel-tourism-santorini-resort-greece-cape-686738.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Let's play",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Wills & Estates",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "- Wishwell -",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: (showBottomMenu) ? 1.0 : 0.0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 200),
              left: 0,
              //bottom: (showBottomMenu) ? 0 : -(height / 3.1),
              bottom: (showBottomMenu) ? 0 : -(height / 1.7),
              child: DrawerWidget(
                isOpen: showBottomMenu,
                metaTitle: '',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  final bool isOpen;
  final String metaTitle;
  const DrawerWidget(
      {super.key, required this.isOpen, required this.metaTitle});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final icon = Icon(
      isOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
      size: 30,
    );
    const String upgradeMessage =
        '\n\n(Upgade your subscription to view this PDF)';

    return FutureBuilder(
        //future: _future,

        builder: (context, snapshot) {
      return Consumer<WillProvider>(builder: (context, willProvider, child) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(
              20,
            ),
            topLeft: Radius.circular(
              20,
            ),
          ),
          child: Container(
            color: Colors.white,
            width: width,
            //height: height / 2.5,
            height: height / 1.5,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    icon,
                    const Text(
                      "View your PDF documents",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Complete your details before previewing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView(
                      // physics: ScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        ...docs.map(
                          (e) => ListTile(
                              title: Text('${e.name} '),
                              subtitle: Text(
                                  '${e.description} ${e.enabled ? '' : upgradeMessage}'),
                              // trailing:
                              //     Text('\$${e.totalCost().toStringAsFixed(2)}'),
                              enabled: e.enabled ? true : false,
                              onTap: () {
                                if (!e.enabled) {
                                  () {};
                                } else if (e.type == 'assets') {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      //builder: (builder) => PdfPreviewClientPage(),
                                      builder: (context) => PdfPreviewWillPage(
                                          pageFormat: PdfPageFormat.a4,
                                          pdf: willProvider,
                                          metaTitle: e.name),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      //builder: (builder) => DetailPage(doc: e),
                                      builder: (context) => PdfPreviewWillPage(
                                          pageFormat: PdfPageFormat.a4,
                                          pdf: willProvider,
                                          metaTitle: e.name),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}
