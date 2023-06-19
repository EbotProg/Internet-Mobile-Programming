import 'package:flutter/material.dart';
import 'package:twiceasmuch/models/chat.dart';
import 'package:twiceasmuch/screens/messages_screen.dart';

class ChatItemWidget extends StatelessWidget {
  // final AppUser user;
  // final VoidCallback onTap;

  const ChatItemWidget(
      {super.key,
      // required this.user,
      // required this.onTap,
      this.chat});

  final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MessagesScreen(),
        ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: chat!.user.picture != null
                  ? ClipOval(
                      child: Image.network(
                        chat!.user.picture!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.asset('assets/Ellipse 4.png'),
                    ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      chat!.user.username!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'Message ${chat!.user.username!}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
