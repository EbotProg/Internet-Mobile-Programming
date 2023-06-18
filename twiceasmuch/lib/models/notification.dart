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

  User? user;
  Food? food;

  Map<String, dynamic> toJson() {
    return {
      'notificationID': notificationID,
      'content': content,
      'foodID': foodID,
      'userID': userID,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> notification) {
    return Notification(
      notificationID: notification['notificationID'],
      content: notification['content'],
      foodID: notification['foodID'],
      userID: notification['userID'],
    );
  }
}
