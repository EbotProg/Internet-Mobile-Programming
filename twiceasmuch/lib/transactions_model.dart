class Transactions {
  Transactions(
      {this.id,
      this.foodid,
      this.discountedprice,
      this.time,
      this.buyerid,
      this.donorid});
  int? id;
  String? foodid;
  double? discountedprice;
  String? time;
  String? buyerid;
  String? donorid;

  Map<String, dynamic> toJson() {
    return {};
  }

  factory Transactions.fromJson(Map<String, dynamic> transactions) {
    return Transactions(
        id: transactions['transactionid'],
        foodid: transactions['foodid'],
        discountedprice: transactions['discountedprice'],
        time: transactions['time'],
        buyerid: transactions['buyerid'],
        donorid: transactions['donorid']);
  }
}
