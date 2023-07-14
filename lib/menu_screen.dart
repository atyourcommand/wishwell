import 'package:flutter/material.dart';
import 'package:wishwell/main.dart';
import 'dart:ui';
import 'package:wishwell/provider/asset_provider.dart';
import 'package:wishwell/provider/client_provider.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:collection_picker/collection_picker.dart';

class CityModel {
  String type;
  String name;

  CityModel(this.type, this.name);
}

List<CityModel> dataCity = [
  CityModel('Question', 'Are you married?'),
  CityModel('Question', 'Do you have children?'),
  CityModel('Option', 'Would you like a burial?'),
  CityModel('Option', 'Are you rich?'),
  CityModel('Option', 'Shall we put in a clause in the event?'),
];

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var clientDoc;

  @override
  void initState() {
    _future = Future.wait([
      Provider.of<ClientProvider>(context, listen: false).selectData(),
      Provider.of<AssetsProvider>(context, listen: false).selectAsset(),
    ]);

    super.initState();
  }

  // ignore: unused_field
  late final Future _future;
  bool showBottomMenu = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var threshold = 100;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'logo',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
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
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              color: Colors.grey.shade200,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Hi mate',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'There\'s no time to waste.',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  // const Padding(
                                  //   padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  //   child: Divider(color: Colors.grey),
                                  // ),
                                  ListViewPicker<CityModel>(
                                    type: PickerType.multiple,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separator:
                                        const Divider(thickness: 1, height: 30),
                                    initialValue: dataCity.first,
                                    data: dataCity,
                                    itemBuilder: (context, index, item) {
                                      return SizedBox(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${item.data?.name}'),
                                            (item.isSelected)
                                                ? Icon(Icons.check,
                                                    color: ColorConstants
                                                        .primaryAppColor)
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                      );
                                    },
                                    onChanged: (context, index, selectedItem,
                                        selectedListItem) {
                                      // when the type is single/radio, you should use this
                                      debugPrint(
                                          'Selected item = $selectedItem');

                                      /// when the type is multiple, you should use this
                                      debugPrint(
                                          'All selected item = $selectedListItem');
                                    },
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  top: 50, left: 20, right: 20),
                              child: Column(
                                children: [
                                  Text(
                                    'Bring it all together ',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Then view your PDF document.',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const ListTile(
                                      leading: SizedBox(
                                          height: double.infinity,
                                          child: Icon(
                                            Icons.announcement_outlined,
                                            size: 36.0,
                                          )),
                                      title: Text('Wishes'),
                                      subtitle: Text('Take your time'),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                      )),
                                  const Divider(thickness: 1, height: 20),
                                  const ListTile(
                                      leading: SizedBox(
                                          height: double.infinity,
                                          child: Icon(
                                            Icons.person_search_sharp,
                                            size: 36.0,
                                          )),
                                      title: Text('Beneficiaries'),
                                      subtitle: Text(
                                          'Create at least one main beneficiary and then gift items to others.'),
                                      trailing: Icon(
                                          Icons.arrow_forward_ios_rounded)),
                                  const Divider(thickness: 1, height: 20),
                                  const ListTile(
                                      leading: SizedBox(
                                          height: double.infinity,
                                          child: Icon(
                                            Icons.house_rounded,
                                            size: 36.0,
                                          )),
                                      title: Text('Assets'),
                                      subtitle: Text('Take your time'),
                                      trailing: Icon(
                                          Icons.arrow_forward_ios_rounded)),
                                  const Divider(thickness: 1, height: 20),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // buildClients(clientList),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showBottomMenu = !showBottomMenu;
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
                                " View PDF templates",
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
                    ],
                  )),
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
                      child: Container(color: Colors.black.withOpacity(0.2)),
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
      ),
    );
  }
}
