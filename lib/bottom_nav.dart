import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import '../pages/profile_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = HomePage();
        break;
      case 3:
        page = ProfilePage();
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      currentIndex: currentIndex,
      onTap: (index) => _navigate(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Upload'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Inbox'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
