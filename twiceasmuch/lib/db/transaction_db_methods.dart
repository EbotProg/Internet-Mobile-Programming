import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/db/payment_db_methods.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/models/transaction.dart';

class TransactionDBMethods {
  final supabaseInstance = Supabase.instance;

  Future<List<Transaction>> getTrasactions(String userId) async {
    try {
      final trasactionsMap1 = await supabaseInstance.client
          .from('transactions')
          .select<List<Map<String, dynamic>>>()
          .eq('buyerid', userId)
          .order('time');
      final trasactionsMap2 = await supabaseInstance.client
          .from('transactions')
          .select<List<Map<String, dynamic>>>()
          .eq('donorid', userId)
          .order('time');

      final users = await UserDBMethods().getUsers();
      final foods = await FoodDBMethods().getFoods();
      final payments = await PaymentDBMethods().getPayments(userId);

      final transactions1 =
          trasactionsMap1.map((e) => Transaction.fromJson(e)).toList();
      final transactions2 =
          trasactionsMap2.map((e) => Transaction.fromJson(e)).toList();
      final trasactions = [...transactions1, ...transactions2];
      trasactions.sort(
        (a, b) => a.time?.compareTo(b.time ?? DateTime.now()) ?? 0,
      );

      for (var transaction in trasactions) {
        if (transaction.foodID != null) {
          transaction.food = foods.firstWhere(
            (food) => food.foodID == transaction.foodID,
          );
        }
        if (transaction.paymentID != null) {
          transaction.payment = payments.firstWhere(
            (payment) => payment.paymentID == transaction.paymentID,
          );
        }
        transaction.donor = users.firstWhere(
          (user) => user.userID == transaction.donorID,
        );
        transaction.buyer = users.firstWhere(
          (user) => user.userID == transaction.buyerID,
        );
      }

      return trasactions;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    try {
      await supabaseInstance.client
          .from('transactions')
          .update(transaction.toJson())
          .eq('transactionid', transaction.transactionID);
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> createTrasaction(Transaction transaction) async {
    try {
      await supabaseInstance.client
          .from('transactions')
          .insert(transaction.toJson());
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }
}
