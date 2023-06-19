import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/models/notification.dart';

class NotificationDBMethods {
  final supabaseInstance = Supabase.instance;

  Future<List<Notification>> getNotifications(String userId) async {
    try {
      final notificationsMap = await supabaseInstance.client
          .from('notifications')
          .select<List<Map<String, dynamic>>>()
          .eq('userid', userId)
          .order('timesent');

      final users = await UserDBMethods().getUsers();
      final foods = await FoodDBMethods().getFoods();

      final notifications =
          notificationsMap.map((e) => Notification.fromJson(e)).toList();
      notifications.sort(
        (a, b) => a.timeSent?.compareTo(b.timeSent ?? DateTime.now()) ?? 0,
      );

      for (var notification in notifications) {
        notification.user = users.firstWhere(
          (user) => user.userID == notification.userID,
        );
        if (notification.foodID != null) {
          notification.food = foods.firstWhere(
            (food) => food.foodID == notification.foodID,
          );
        }
      }

      return notifications;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> createNotification(Notification notification) async {
    try {
      await supabaseInstance.client
          .from('notifications')
          .insert(notification.toJson());
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }
}
