import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/user.dart';

class Notification {
  Notification({
    this.notificationID,
    this.content,
    this.foodID,
    this.userID,
  });

  int? notificationID;
  int? foodID;
  int? userID;
  String? content;

  AppUser? user;
  Food? food;

  Map<String, dynamic> toJson() {
    return {
      'notificationid': notificationID,
      'content': content,
      'foodid': foodID,
      'userid': userID,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> notification) {
    return Notification(
      notificationID: notification['notificationid'],
      content: notification['content'],
      foodID: notification['foodid'],
      userID: notification['userid'],
    );
  }
}
