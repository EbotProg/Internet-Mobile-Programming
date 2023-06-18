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

  User? depositor;
  User? withdrawer;

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'amount': amount,
      'depositorID': depositorID,
      'withdrawerID': withdrawerID,
      'status': status.toString(),
      'timeOfDeposit': DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeOfDeposit ?? DateTime.now()).toUtc(),
      ),
      'timeOfWithdrawal': DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (timeOfWithdrawal ?? DateTime.now()).toUtc(),
      ),
    };
  }

  factory Payment.fromJson(Map<String, dynamic> payment) {
    return Payment(
      paymentID: payment['paymentID'],
      amount: payment['amount'],
      depositorID: payment['depositorID'],
      withdrawerID: payment['withdrawerID'],
      status: PaymentStatus.fromString(payment['status']),
      timeOfDeposit: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(payment['timeOfDeposit'])
          .toLocal(),
      timeOfWithdrawal: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(payment['timeOfWithdrawal'])
          .toLocal(),
    );
  }
}
