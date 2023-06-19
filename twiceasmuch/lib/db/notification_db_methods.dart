import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/notification.dart';
import 'package:twiceasmuch/models/user.dart';

class NotificationDBMethods {
  final supabaseInstance = Supabase.instance;

  Future<List<Notification>> getNotifications(String userId) async {
    try {
      final notificationsMap = await supabaseInstance.client
          .from('notifications')
          .select<List<Map<String, dynamic>>>()
          .eq('userid', userId)
          .order('timesent');

      final fetches = [
        UserDBMethods().getUsers(),
        FoodDBMethods().getFoods(),
      ];

      final results = await Future.wait(fetches);

      final users = results[0] as List<AppUser>;
      final foods = results[1] as List<Food>;

      final notifications =
          notificationsMap.map((e) => Notification.fromJson(e)).toList();
      notifications.sort(
        (a, b) => b.timeSent?.compareTo(a.timeSent ?? DateTime.now()) ?? 0,
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
