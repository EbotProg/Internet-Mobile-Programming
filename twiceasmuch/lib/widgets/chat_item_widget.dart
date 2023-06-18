import 'package:flutter/material.dart';
import 'package:twiceasmuch/screens/messages_screen.dart';

class ChatItemWidget extends StatelessWidget {
  // final AppUser user;
  // final VoidCallback onTap;
  const ChatItemWidget({
    super.key,
    // required this.user,
    // required this.onTap,
  });

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
              child:
                  //  user.imageUrl != null
                  //     ? ClipOval(
                  //         child: Image.network(
                  //           user.imageUrl!,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       )
                  //     :
                  ClipOval(
                child: Image.asset('assets/Ellipse 4.png'),
              ),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Ellie',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Say Hi to Ellie',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(height: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
