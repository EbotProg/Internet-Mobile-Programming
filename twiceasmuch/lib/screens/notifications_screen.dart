import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        backgroundColor: const Color(0xff292E2A),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: List.filled(15, getItem),
          ),
        ),
      ),
    );
  }

  Widget get getItem => Container(
        decoration: const BoxDecoration(
          color: Color(0xffF0F0F0),
          border: Border(
            right: BorderSide(
              color: Color(0xff20B970),
              width: 2,
            ),
          ),
          // borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Nji Caleb',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('7:26 PM'),
              ],
            ),
            SizedBox(height: 5),
            Text('Fufu and Eru'),
          ],
        ),
      );
}
