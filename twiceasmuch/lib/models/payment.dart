import 'package:intl/intl.dart';
import 'package:twiceasmuch/enums/payment_status.dart';
import 'package:twiceasmuch/models/user.dart';

class Payment {
  Payment({
    this.paymentID,
    required this.amount,
    this.status,
    required this.depositorID,
    required this.timeOfDeposit,
    this.timeOfWithdrawal,
    required this.withdrawerID,
  });

  int? paymentID;
  double? amount;
  PaymentStatus? status;
  DateTime? timeOfDeposit;
  DateTime? timeOfWithdrawal;
  String? depositorID;
  String? withdrawerID;

  AppUser? depositor;
  AppUser? withdrawer;

  Map<String, dynamic> toJson() {
    return {
      'paymentid': paymentID,
      'amount': amount,
      'depositorid': depositorID,
      'withdrawerid': withdrawerID,
      'status': status.toString(),
      'timeofdeposit': DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeOfDeposit ?? DateTime.now()).toUtc(),
      ),
      'timeofwithdrawal': DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeOfWithdrawal ?? DateTime.now()).toUtc(),
      ),
    };
  }

  factory Payment.fromJson(Map<String, dynamic> payment) {
    return Payment(
      paymentID: payment['paymentid'],
      amount: payment['amount'],
      depositorID: payment['depositorid'],
      withdrawerID: payment['withdrawerid'],
      status: PaymentStatus.fromString(payment['status']),
      timeOfDeposit: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(payment['timeofdeposit'])
          .toLocal(),
      timeOfWithdrawal: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(payment['timeofwithdrawal'])
          .toLocal(),
    );
  }
}
