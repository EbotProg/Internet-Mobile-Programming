enum PaymentStatus {
  pending,
  deposited,
  withdrawed;

  factory PaymentStatus.fromString(String value) {
    return PaymentStatus.values.firstWhere(
      (element) => value == element.name,
      orElse: () => PaymentStatus.pending,
    );
  }

  @override
  String toString() {
    return name;
  }
}
