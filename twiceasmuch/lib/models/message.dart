import 'package:intl/intl.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/user.dart';

class Message {
  final int? messageID;
  final String? senderID;
  final String? receiverID;
  final String? content;
  final DateTime? timeSent;
  final int? foodID;

  User? sender;
  User? receiver;
  Food? food;

  Message({
    this.messageID,
    this.senderID,
    this.foodID,
    this.receiverID,
    this.content,
    this.timeSent,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageID: json['messageID'],
      senderID: json['senderID'],
      foodID: json['foodID'],
      receiverID: json['receiverID'],
      timeSent: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(json['uploadedAt'])
          .toLocal(),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messageID": messageID,
      "senderID": senderID,
      "foodID": foodID,
      "receiverID": receiverID,
      "timeSent": DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeSent ?? DateTime.now()).toUtc(),
      ),
      "content": content,
    };
  }
}
