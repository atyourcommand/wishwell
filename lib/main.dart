import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/nav.dart';
import 'package:wishwell/provider/asset_provider.dart';
import 'package:wishwell/provider/client_provider.dart';
import 'package:wishwell/provider/user_provider.dart';

void main() => runApp(const MyApp());

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color primaryAppColor = hexToColor('#4f73eb');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// This widget is the root
// of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ClientProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AssetsProvider(),
        ),
        ChangeNotifierProvider<WillProvider>(
          create: (context) => WillProvider(),
        ),
      ],
      child: MaterialApp(
        title: "ListView.builder",
        //theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
        //home: const ListTileApp());
        home: const Nav(),
      ),
    );
  }
}

/*
1. Beneficiaries Page: 
- Try to move the PDF button, next to the +add button.✅
- Make the list of beneficiaries scrollable whilst keeping the white heading section fixed.✅
- Add to the cards under the name of the asset, the number of assets allocated to that person.

2. My Wishes Page:✅
- Make the TO DO lists scrollable whilst keeping the white heading section fixed. Fix overflow issue.

3. Assets Page:✅
- Make the list of assets scrollable whilst keeping the white heading section fixed. Fix overflow issue.
- I would like to use font awesome icons in the careds as you can see I have used 'FontAwesomeIcons.piggyBank,'.
Can you use the method in the ENUMS to point to the appropriate icon names. I was unable to get this working.
FontAwesomeIcons.piggyBank,  FontAwesomeIcons.buildingColumns, FontAwesomeIcons.warehouse, FontAwesomeIcons.sackDollar,

4. Beneficiaries DETAIL Page: 
- Add a list of assets that have been assigned to that person.✅
- It would be great if we could also link each item to relevant Asset Detail page also.✅
*/ 