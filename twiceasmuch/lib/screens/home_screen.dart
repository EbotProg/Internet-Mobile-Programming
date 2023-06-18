import 'package:flutter/material.dart';
import 'package:twiceasmuch/screens/account_screen.dart';
import 'package:twiceasmuch/screens/chats_screen.dart';
import 'package:twiceasmuch/screens/list_of_uploads/list_of_uploads.dart';
import 'package:twiceasmuch/screens/notifications_screen.dart';
import 'package:twiceasmuch/screens/starter_screen.dart';
import 'package:twiceasmuch/screens/transactions_screen.dart';
import 'package:twiceasmuch/screens/upload_food.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final screens = [
    const StarterScreen(),
    const ListOfUploads(),
    const ChatsScreen(),
    const TrasactionsScreen(),
  ];

  final titles = [
    '2ICEASMUCH',
    'Inventory',
    'Chats',
    'Trasactions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff292E2A),
        centerTitle: true,
        title: Text(
          titles[index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
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
        actions: [
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
      floatingActionButton: index == 1
          ? FloatingActionButton(
              child: const Icon(Icons.upload),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => const UploadFoodScreen(),
                ));
              },
            )
          : null,
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.upload),
          //   label: 'Upload',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_sharp),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration_sharp),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
