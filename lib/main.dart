import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/nav.dart';
import 'package:wishwell/provider/client_provider.dart';

void main() => runApp(const MyApp());

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
        )
      ],
      child: MaterialApp(
          title: "ListView.builder",
          theme: ThemeData(primarySwatch: Colors.blue),
          debugShowCheckedModeBanner: false,
          // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
          //home: const ListTileApp());
          home: const Nav()),
    );
  }
}
