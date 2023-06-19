import 'package:intl/intl.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/user.dart';

class Message {
  int? messageID;
  String? senderID;
  String? receiverID;
  String? content;
  DateTime? timeSent;
  int? foodID;
  bool? isRead;

  AppUser? sender;
  AppUser? receiver;
  Food? food;
  bool local;

  Message({
    this.messageID,
    this.senderID,
    this.foodID,
    this.receiverID,
    this.content,
    this.timeSent,
    this.isRead,
    this.local = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageID: json['messageid'],
      senderID: json['senderid'],
      foodID: json['foodid'],
      receiverID: json['receiverid'],
      timeSent: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(json['timesent'])
          .toLocal(),
      content: json['content'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "messageid": messageID,
      "senderid": senderID,
      "foodid": foodID,
      "receiverid": receiverID,
      "timesent": DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeSent ?? DateTime.now()).toUtc(),
      ),
      "content": content,
      "isRead": isRead,
    };
  }
}
