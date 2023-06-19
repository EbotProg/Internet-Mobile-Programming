enum FoodState {
  none,
  cooked,
  raw;

  factory FoodState.fromString(String value) {
    return FoodState.values.firstWhere(
      (element) => value == element.name,
      orElse: () => FoodState.cooked,
    );
  }

  @override
  String toString() {
    return name;
  }

  String displayString() {
    return name;
  }
}
