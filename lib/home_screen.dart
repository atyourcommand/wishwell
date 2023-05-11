import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/document_model.dart';
import 'package:wishwell/pdf/detail_page.dart';

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
      name: 'Create and deploy software package'),
  Doc(
    client: 'Michael Ambiguous',
    address: '82 Unsure St\r\nBaggle Palace',
    items: [
      LineItem('Professional Advice', 100),
      LineItem('Lunch Bill', 43.55),
      LineItem('Remote Assistance', 50),
    ],
    name: 'Provide remote support after lunch',
  ),
  Doc(
    client: 'Marty McDanceFace',
    address: '55 Dancing Parade\r\nDance Place',
    items: [
      LineItem('Program the robots', 400.50),
      LineItem('Find tasteful dance moves for the robots', 80.55),
      LineItem('General quality assurance', 80),
    ],
    name: 'Create software to teach robots how to dance',
  ),
];
bool showBottomMenu = false;

class _HomeState extends State<Home> {
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
                                // image: const DecorationImage(
                                //   image: NetworkImage(
                                //       "https://get.pxhere.com/photo/beach-sea-coast-ocean-architecture-house-town-vacation-travel-village-mediterranean-tower-seascape-bay-island-blue-chapel-tourism-santorini-resort-greece-cape-686738.jpg"),
                                //   fit: BoxFit.cover,
                                // ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
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
              bottom: (showBottomMenu) ? 0 : -(height / 3),
              child: const DrawerWidget(),
            )
          ]),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    const icon = Icon(
      Icons.keyboard_arrow_up,
      size: 30,
    );
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
        height: height / 3 + 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          child: Column(children: <Widget>[
            icon,
            const Text(
              "View your PDF document",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "The document can live in this container",
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
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                ...docs.map(
                  (e) => ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.name),
                    trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => DetailPage(doc: e),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // ListView.builder(
            //   itemCount: 1,
            //   itemBuilder: (context, index) {

            //   return ListTile(

            //       title: Text(client?.firstName??""),
            //       subtitle: Text(client?.address1 ??""),
            //       trailing: Text('\$${client?.firstName??""}'),
            //       onTap: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (builder) => DetailPage(doc: client),
            //           ),
            //         );
            //       });
            // })
          ]),
        ),
      ),
    );
  }
}
