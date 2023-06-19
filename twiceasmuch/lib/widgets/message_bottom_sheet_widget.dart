import 'package:flutter/material.dart';
import 'package:twiceasmuch/db/chat_db_methods.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/message.dart';
import 'package:twiceasmuch/models/user.dart';
import 'package:twiceasmuch/utilities/sign_up_utils.dart';
import 'package:twiceasmuch/utilities/snackbar_utils.dart';

class MessageBottomSheetWidget extends StatefulWidget {
  final AppUser user;
  final Food food;
  const MessageBottomSheetWidget({
    super.key,
    required this.user,
    required this.food,
  });

  @override
  State<MessageBottomSheetWidget> createState() =>
      _MessageBottomSheetWidgetState();
}

class _MessageBottomSheetWidgetState extends State<MessageBottomSheetWidget> {
  bool sending = false;

  @override
  void initState() {
    nameSignUpController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameSignUpController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 450,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: signUpKey,
          child: Column(children: [
            const SizedBox(height: 30),
            Text(
              'Message ${widget.user.username ?? ''}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: nameSignUpController,
              focusNode: nameSignUpFocus,
              validator: (input) {
                if (input == null) {
                  return 'Please enter message';
                }

                return null;
              },
              decoration: const InputDecoration(
                label: Text('Message'),
                border: OutlineInputBorder(),
                fillColor: Color(0xffECECEC),
              ),
              maxLines: 5,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: sending
                    ? () {}
                    : () async {
                        if (signUpKey.currentState!.validate()) {
                          if (!mounted) return;
                          setState(() {
                            sending = true;
                          });
                          await ChatDBMethods().sendMessage(
                            Message(
                              content: nameSignUpController!.text,
                              isRead: false,
                              senderID: globalUser!.userID,
                              receiverID: widget.user.userID,
                              timeSent: DateTime.now(),
                              foodID: widget.food.foodID,
                              // verificationStatus: true,
                            ),
                          );
                          snackbarSuccessful(
                            title: 'Message sent successfully',
                            context: context,
                          );
                          Navigator.of(context).pop();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: sending
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      )
                    : const Text(
                        'Send Message',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
