import 'package:intl/intl.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/user.dart';

class Message {
  final int? messageID;
  final String? senderID;
  final String? receiverID;
  final String? content;
  final DateTime? timeSent;
  final int? foodID;
  final bool? isRead;

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
    this.isRead,
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
      isRead: json['isRead'],
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
      "isRead": isRead,
    };
  }
}
