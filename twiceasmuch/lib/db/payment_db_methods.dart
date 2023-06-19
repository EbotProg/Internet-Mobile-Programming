import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/models/payment.dart';

class PaymentDBMethods {
  final supabaseInstance = Supabase.instance;

  Future<List<Payment>> getPayments(String userId) async {
    try {
      final paymentsMap1 = await supabaseInstance.client
          .from('payment')
          .select<List<Map<String, dynamic>>>()
          .eq('depositorid', userId)
          .order('timeofdeposit');
      final paymentsMap2 = await supabaseInstance.client
          .from('payment')
          .select<List<Map<String, dynamic>>>()
          .eq('withdrawerid', userId)
          .order('timeofdeposit');

      final users = await UserDBMethods().getUsers();

      final payments1 = paymentsMap1.map((e) => Payment.fromJson(e)).toList();
      final payments2 = paymentsMap2.map((e) => Payment.fromJson(e)).toList();
      final payments = [...payments1, ...payments2];
      payments.sort(
        (a, b) =>
            a.timeOfDeposit?.compareTo(b.timeOfDeposit ?? DateTime.now()) ?? 0,
      );

      for (var payment in payments) {
        payment.depositor = users.firstWhere(
          (user) => user.userID == payment.depositorID,
        );
        payment.withdrawer = users.firstWhere(
          (user) => user.userID == payment.withdrawerID,
        );
      }

      return payments;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updatePayment(Payment payment) async {
    try {
      await supabaseInstance.client
          .from('payment')
          .update(payment.toJson())
          .eq('paymentid', payment.paymentID);
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> createPayment(Payment payment) async {
    try {
      await supabaseInstance.client.from('payment').insert(payment.toJson());
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }
}
