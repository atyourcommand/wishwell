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
  static Color primaryAppColor = hexToColor('#5E92F3');
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
