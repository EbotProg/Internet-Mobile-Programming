import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/models/chat.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/message.dart';

class ChatDBMethods {
  final supabaseInstance = Supabase.instance;

  Future<List<Chat>> getChats(String userId) async {
    try {
      final messagesMap1 = await supabaseInstance.client
          .from('messages')
          .select<List<Map<String, dynamic>>>()
          .contains('senderid', userId)
          .order('timeSent');
      final messagesMap2 = await supabaseInstance.client
          .from('messages')
          .select<List<Map<String, dynamic>>>()
          .contains('receiverid', userId)
          .order('timesent');

      final users = await UserDBMethods().getUsers();
      final foods = await FoodDBMethods().getFoods();

      final messages1 = messagesMap1.map((e) => Message.fromJson(e)).toList();
      final messages2 = messagesMap2.map((e) => Message.fromJson(e)).toList();
      final messages = [...messages1, ...messages2];
      messages.sort(
        (a, b) => a.timeSent?.compareTo(b.timeSent ?? DateTime.now()) ?? 0,
      );

      final chats = <Chat>[];
      messages.forEach((message) {
        if (message.foodID != null) {
          message.food = foods.firstWhere(
            (food) => food.foodID == message.foodID,
          );
        }
        final otherUser = message.receiverID == userId
            ? message.senderID
            : message.receiverID;
        final index = chats.indexWhere((chat) => chat.user.userID == otherUser);
        if (index != -1) {
          chats[index].messages.add(message);
        } else {
          chats.add(
            Chat(
              user: users.firstWhere((user) => user.userID == otherUser),
              messages: [message],
            ),
          );
        }
      });

      return chats;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      await supabaseInstance.client.from('messages').insert(message.toJson());
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Stream<List<Message>> subscribeChat({
    required String myId,
    required String senderId,
  }) {
    return supabaseInstance.client
        .from('messages')
        .select<List<Map<String, dynamic>>>()
        .in_('senderid', [senderId, myId])
        .in_('receiverid', [myId, senderId])
        .order('timesent')
        .asStream()
        .map(
          (event) => event
              .map(
                (e) => Message.fromJson(e),
              )
              .toList(),
        );
  }


}
