import 'package:flutter/material.dart';
import 'package:food_donation_platform_app/screens/account_screen.dart';
import 'package:food_donation_platform_app/screens/notifications_screen.dart';
import 'package:food_donation_platform_app/screens/starter_screen.dart';
import 'package:food_donation_platform_app/screens/upload_food.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final screens = [
    const StarterScreen(),
    const UploadFoodScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff292E2A),
        title: const Text(
          'F',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              foregroundImage: AssetImage('assets/Ellipse 4.png'),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
            tooltip: 'Account',
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Color(0xff20B970),
            ),
            iconSize: 35,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        selectedItemColor: const Color(0xff20B970),
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
