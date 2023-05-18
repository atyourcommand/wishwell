import 'package:flutter/material.dart';
import 'package:wishwell/Assets/asset_screen.dart';
//import 'package:wishwell/user_add.dart';
//import 'package:wishwell/client_detail.dart';
//import 'package:wishwell/provider/client_provider.dart';
//import 'package:wishwell/provider/client_provider.dart';
//import 'package:wishwell/provider/client_provider.dart';
//import 'package:wishwell/provider/client_provider.dart';
import 'package:wishwell/user_screen.dart';
import 'package:wishwell/home_screen.dart';
//import './common_controller.dart';
//import 'package:wishwell/legatee_screen.dart';
import 'package:wishwell/client_screen.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  // static move() {
  //   int count = 3;
  //   return count;
  // }

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    //const Home(),
    const Home(),
    const UserScreen(),
    const ClientScreen(),
    const AssetScreen(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('Bottom Nav Bar'),
      //),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey.shade600,
            ),
            // backgroundColor: Colors.blue,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: Colors.grey.shade600,
            ),
            // backgroundColor: Colors.white,
            label: 'User Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.grey.shade600,
            ),
            // backgroundColor: Colors.blue,
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Colors.blue,
            icon: Icon(
              Icons.hotel_class_rounded,
              color: Colors.grey.shade600,
            ),
            label: 'Assets',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
