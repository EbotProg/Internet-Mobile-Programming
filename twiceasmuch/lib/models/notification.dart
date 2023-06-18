import 'package:intl/intl.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/user.dart';

class Notification {
  Notification({
    this.notificationID,
    this.content,
    this.foodID,
    this.userID,
    this.timeSent,
  });

  int? notificationID;
  int? foodID;
  String? userID;
  String? content;
  DateTime? timeSent;

  AppUser? user;
  Food? food;

  Map<String, dynamic> toJson() {
    return {
      'notificationid': notificationID,
      'content': content,
      'foodid': foodID,
      'userid': userID,
      'timesent': DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeSent ?? DateTime.now()).toUtc(),
      ),
    };
  }

  factory Notification.fromJson(Map<String, dynamic> notification) {
    return Notification(
      notificationID: notification['notificationid'],
      content: notification['content'],
      foodID: notification['foodid'],
      userID: notification['userid'],
      timeSent: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(notification['timesent'])
          .toLocal(),
    );
  }
}
