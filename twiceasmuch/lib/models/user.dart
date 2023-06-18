class User {
  User({
    this.userID,
    this.email,
    this.username,
    this.location,
    this.verificationStatus = false,
    this.rating,
    this.isDonor = false,
    this.picture,
    this.occupation,
    this.phoneNumber,
  });

  String? userID;
  String? username;
  String? email;
  String? location;
  bool verificationStatus;
  double? rating;
  bool isDonor;
  String? picture;
  String? phoneNumber;
  String? occupation;

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
      'email': email,
      'location': location,
      'verificationStatus': verificationStatus,
      'rating': rating,
      'isDonor': isDonor,
      'picture': picture,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
    };
  }

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      userID: user['userID'],
      username: user['username'],
      email: user['email'],
      location: user['location'],
      verificationStatus: user['verificationstatus'],
      rating: user['rating'],
      isDonor: user['isDonor'],
      picture: user['picture'],
      phoneNumber: user['phoneNumber'],
      occupation: user['occupation'],
    );
  }

  @override
  String toString() {
    return "{userid: $userID, username: $username, email: $email,  location: $location, verificationstatus: $verificationStatus,  rating: $rating, isDonor: $isDonor, picture: $picture }";
  }
}
