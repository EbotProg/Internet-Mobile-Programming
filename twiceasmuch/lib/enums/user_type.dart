enum UserType {
  user,
  donor;

  factory UserType.fromString(String value) {
    return UserType.values.firstWhere(
      (element) => value == element.name,
      orElse: () => UserType.user,
    );
  }

  @override
  String toString() {
    return name;
  }

  String displayString() {
    return name[0].toUpperCase() + name.substring(1);
  }
}
