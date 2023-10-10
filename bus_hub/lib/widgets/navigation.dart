import 'package:flutter/material.dart';
import '../screens/home.dart';
import 'package:bus_hub/screens/rides.dart';
import 'package:bus_hub/screens/qr.dart';
import 'package:bus_hub/screens/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key, required this.initialIndex}) : super(key: key);

  final int initialIndex;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex =
      0; // Use a non-final variable to store the selected index

  final List<Widget> _screens = [
    const Home(),
    const Rides(),
    const QR(),
    const Profile()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.initialIndex; // Initialize with the provided initial index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (newIndex) {
          setState(() {
            // Update the selected index when a tab is tapped
            _selectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
