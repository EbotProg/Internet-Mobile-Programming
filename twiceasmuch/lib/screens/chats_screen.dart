import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/chat_db_methods.dart';
import 'package:twiceasmuch/models/chat.dart';
import 'package:twiceasmuch/widgets/chat_item_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Chat> chats = [];
  bool loading = false;
  Future<void> getChats() async {
    loading = true;
    if (!mounted) return;
    setState(() {});

    chats = await ChatDBMethods()
        .getChats(Supabase.instance.client.auth.currentUser!.id);
    loading = false;
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getChats();
      },
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : chats.isEmpty
              ? const Center(
                  child: Text("No chats yet!"),
                )
              : RefreshIndicator(
                  onRefresh: getChats,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
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
                          ...List.generate(chats.length,
                              (index) => ChatItemWidget(chat: chats[index])),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
