import 'package:flutter/material.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/chat.dart';
import 'package:twiceasmuch/screens/messages_screen.dart';

class ChatItemWidget extends StatelessWidget {
  // final AppUser user;
  // final VoidCallback onTap;

  const ChatItemWidget({
    super.key,
    // required this.user,
    // required this.onTap,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MessagesScreen(
            chat: chat,
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              height: 40,
              width: 40,
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: chat.user.picture != null
                    ? Image.network(
                        chat.user.picture!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/profile.png',
                        fit: BoxFit.cover,
                      ),
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
                      chat.user.username!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const SizedBox(height: 5),
                  if (chat.messages.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'Message ${chat.user.username!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.messages.last.content ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chat.messages.any((element) =>
                              element.isRead != true &&
                              element.receiverID == globalUser?.userID))
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff20B970),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                chat.messages
                                    .where((element) =>
                                        element.isRead != true &&
                                        element.receiverID ==
                                            globalUser?.userID)
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                        ],
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
