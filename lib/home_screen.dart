import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:wishwell/pdf.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

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
          child: Column(children: const <Widget>[
            Icon(
              Icons.keyboard_arrow_up,
              size: 30,
            ),
            Text(
              "View your PDF document",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(),
            Text(
              "The document can live in this container",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
