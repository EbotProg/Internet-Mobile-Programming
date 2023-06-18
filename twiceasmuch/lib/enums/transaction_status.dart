enum TransactionStatus {
  requested,
  delivered;

  factory TransactionStatus.fromString(String value) {
    return TransactionStatus.values.firstWhere(
      (element) => value == element.name,
      orElse: () => TransactionStatus.requested,
    );
  }

  @override
  String toString() {
    return name;
  }
}
