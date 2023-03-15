import 'package:flutter/material.dart';
import 'package:wishwell/details_screen.dart';
import 'package:wishwell/legatee_screen.dart';
import 'package:wishwell/client_screen.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});
  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    //const Home(),
    const DetailsScreen(),
    const LegateeScreen(),
    const ClientScreen(),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Clients',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ));
  }
}
