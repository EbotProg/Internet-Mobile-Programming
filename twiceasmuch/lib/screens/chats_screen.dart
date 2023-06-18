import 'package:flutter/material.dart';
import 'package:twiceasmuch/widgets/chat_item_widget.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 0),
            //   child: Text(
            //     'Chats',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 30,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
            ...List.filled(10, const ChatItemWidget()),
          ],
        ),
      ),
    );
  }
}
