import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twiceasmuch/db/chat_db_methods.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/chat.dart';
import 'package:twiceasmuch/models/message.dart';

class MessagesScreen extends StatefulWidget {
  final Chat chat;
  const MessagesScreen({
    super.key,
    required this.chat,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late List<Message> messages;
  late TextEditingController messageController;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages = widget.chat.messages;
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final messages = await ChatDBMethods().getMessages(
        myId: globalUser!.userID!,
        senderId: widget.chat.user.userID!,
      );

      final localMessages =
          this.messages.where((element) => element.local).toList();
      localMessages.removeWhere((element) => messages.any((message) =>
          message.content == element.content &&
          message.timeSent == element.timeSent));

      messages.addAll(localMessages);
      this.messages = messages;
      widget.chat.messages = messages;
      Future.delayed(Duration.zero, () {
        if (!mounted) return;
        setState(() {});
      });
    });
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292E2A),
      appBar: AppBar(
        backgroundColor: const Color(0xff292E2A),
        // leading: null,
        automaticallyImplyLeading: false,
        title: SizedBox(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                height: 40,
                width: 40,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: widget.chat.user.picture != null
                      ? Image.network(
                          widget.chat.user.picture!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/profile.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                widget.chat.user.username ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final isMine =
                        messages[index].senderID == globalUser?.userID;
                    if (!isMine && messages[index].isRead != true) {
                      ChatDBMethods().markMessageAsRead(messages[index]);
                    }
                    return Align(
                      alignment:
                          isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                          minWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isMine
                                ? const Color(0xff20B970)
                                : const Color(0xff292E2A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 10,
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages[index].content ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  DateFormat.jm().format(
                                      messages[index].timeSent ??
                                          DateTime.now()),
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text('Message...'),
                          border: OutlineInputBorder(),
                          fillColor: Color(0xffECECEC),
                        ),
                        controller: messageController,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final message = messageController.text;
                        messageController.clear();
                        final messageObject = Message(
                          content: message,
                          isRead: false,
                          receiverID: widget.chat.user.userID,
                          senderID: globalUser?.userID,
                          timeSent: DateTime.now().copyWith(
                            millisecond: 0,
                            microsecond: 0,
                          ),
                          local: true,
                        );
                        messages.add(messageObject);
                        widget.chat.messages = messages;
                        if (!mounted) return;
                        setState(() {});
                        await ChatDBMethods().sendMessage(messageObject);

                        if (!mounted) return;
                        setState(() {});
                      },
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
