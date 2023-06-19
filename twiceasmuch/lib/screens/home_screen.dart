import 'package:flutter/material.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/enums/user_type.dart';
import 'package:twiceasmuch/global.dart';
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
  bool loading = true;

  List<Widget> screens() {
    return [
      const StarterScreen(),
      if (globalUser?.userType == UserType.donor) const ListOfUploads(),
      const ChatsScreen(),
      const TrasactionsScreen(),
    ];
  }

  final titles = [
    '2ICEASMUCH',
    'Inventory',
    'Chats',
    'Trasactions',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    globalUser ??= await UserDBMethods().getCurrenUser();
    setState(() {
      loading = false;
    });
  }

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
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
            ),
            clipBehavior: Clip.hardEdge,
            height: 150,
            width: 150,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: globalUser?.picture != null
                  ? Image.network(
                      globalUser!.picture!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/profile.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AccountScreen(),
              ),
            );
            setState(() {});
          },
          tooltip: 'Account',
        ),
        actions: [
          if (!loading)
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : screens()[index],
      floatingActionButton: index == 1
          ? FloatingActionButton(
              child: const Icon(Icons.upload),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => const UploadFoodScreen(
                    shouldEdit: false,
                  ),
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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.upload),
          //   label: 'Upload',
          // ),
          if (globalUser?.userType == UserType.donor)
            const BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_sharp),
              label: 'Inventory',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration_sharp),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
