import 'package:intl/intl.dart';
import 'package:twiceasmuch/enums/transaction_status.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/payment.dart';
import 'package:twiceasmuch/models/user.dart';

class Transaction {
  Transaction({
    this.transactionID,
    this.foodID,
    this.discountedPrice,
    this.time,
    this.buyerID,
    this.donorID,
    this.paymentID,
    this.status,
  });

  int? transactionID;
  int? foodID;
  int? paymentID;
  double? discountedPrice;
  DateTime? time;
  String? buyerID;
  String? donorID;
  TransactionStatus? status;

  AppUser? buyer;
  AppUser? donor;
  Food? food;
  Payment? payment;

  Map<String, dynamic> toJson() {
    return {
      'transactionID': transactionID,
      'foodID': foodID,
      'discountedPrice': discountedPrice,
      'time': DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (time ?? DateTime.now()).toUtc(),
      ),
      'buyerID': buyerID,
      'donorID': donorID,
      'paymentID': paymentID,
      'status': status.toString(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> transaction) {
    return Transaction(
      transactionID: transaction['transactionID'],
      foodID: transaction['foodID'],
      discountedPrice: transaction['discountedPrice'],
      time: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(transaction['time'])
          .toLocal(),
      buyerID: transaction['buyerID'],
      donorID: transaction['donorID'],
      paymentID: transaction['paymentID'],
      status: TransactionStatus.fromString(transaction['status']),
    );
  }
}
