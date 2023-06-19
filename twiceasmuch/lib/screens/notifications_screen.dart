import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/notification_db_methods.dart';
import 'package:twiceasmuch/models/notification.dart' as notification;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<notification.Notification> notifications = [];
  bool isloading = false;

  void getNotification() async {
    isloading = true;
    setState(() {});
    notifications = await NotificationDBMethods()
        .getNotifications(Supabase.instance.client.auth.currentUser!.id);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getNotification();
    super.initState();
  }

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
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(
                0xff20B970,
              ),
            ))
          : notifications.isEmpty
              ? const Center(child: Text("No Notifications yet"))
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      children: List.generate(notifications.length,
                          (index) => getItem(notifications[index])),
                    ),
                  ),
                ),
    );
  }

  Widget getItem(notification.Notification notification) {
    return Container(
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
            children: [
              Text(
                '${notification.user!.username}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(DateFormat.MEd()
                  .format(notification.timeSent ?? DateTime.now())),
            ],
          ),
          const SizedBox(height: 5),
          Text('${notification.content}'),
        ],
      ),
    );
  }
}
