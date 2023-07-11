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

var myThemeColor = const Color.fromARGB(255, 108, 142, 235);

class ColorConstants {
  static Color primaryAppColor = const Color.fromARGB(255, 108, 142, 235);
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
          fontFamily: 'Inter',
          primarySwatch: Colors.blue,
          primaryColor: Colors.red,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontFamily: 'Inter', fontSize: 72, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: 'Inter', fontSize: 26, fontWeight: FontWeight.bold),
            // Form Inputs
            titleMedium: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.normal),
            titleSmall: TextStyle(
                fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w800),
            bodyLarge: TextStyle(
                fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.black54, width: 0.5),
            ),
          ),
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



/*
Thank you for you work on the beneficiaries and assets
Concept
* All PDF previews will eventually be done here.
* Create a list of templates for the user
* Take the name from the document “title” like this
 final pdf = pw.Document(title: ’’Template 1, author: ‘Users Name’);
* Copy 3 or 4 of the existing pdf_will_1 and rename etc for new version prototypes
* Each listing can be clicked for a preview.
* Disabled listings cannot be previewed. A modal may be utilised to reenforce this message.
* Devise a system where we can make some previews and UI as disabled. Future proof this method so we can integrate an App Store upgrade method later.
* Maybe !!! The drawer widget could be accessed from any page!  ^ View PDF templates ____________________________  Complete your details before previewing  Beneficiaries/Assets Assign and share your assets easily
Template 1  A simple template   Template 2 (upgrade required) [disabled] A template with extras  Template 3 (upgrade required) [disabled] A template with more extras  Template 4 (upgrade required) [disabled] A template with more extras
does this seem ok to you?*/