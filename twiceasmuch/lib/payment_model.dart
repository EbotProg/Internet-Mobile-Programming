class Payment {
  Payment(
      {this.id,
      required this.amount,
      this.status,
      required this.depositorid,
      this.timeofdeposit,
      this.timeofwithdrawal,
      required this.withdrawerid});
  int? id;
  double? amount;
  String? status;
  String? timeofdeposit;
  String? timeofwithdrawal;
  String? depositorid;
  String? withdrawerid;

  Map<String, dynamic> toJson() {
    return {};
  }

  factory Payment.fromJson(Map<String, dynamic> payment) {
    return Payment(
        id: payment['id'],
        amount: payment['amount'],
        depositorid: payment['depositorid'],
        withdrawerid: payment['withdrawerid'],
        status: payment['status'],
        timeofdeposit: payment['timeofdeposit'],
        timeofwithdrawal: payment['timeofwidrawal']);
  }
}
