import 'package:twiceasmuch/models/message.dart';
import 'package:twiceasmuch/models/user.dart';

class Chat {
  List<Message> messages;
  User user;

  Chat({
    required this.messages,
    required this.user,
  });
}
