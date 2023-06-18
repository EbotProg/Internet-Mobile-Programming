class AppUser {
  AppUser({
    this.userID,
    this.email,
    this.username,
    this.location,
    this.verificationStatus = false,
    this.rating,
    this.isDonor = false,
    this.picture,
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

  Map<String, dynamic> toJson() {
    return {
      'userid': userID,
      'username': username,
      'email': email,
      'location': location,
      'verificationstatus': verificationStatus,
      'rating': rating,
      'isdonor': isDonor,
      'picture': picture,
      'phonenumber': phoneNumber,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> user) {
    return AppUser(
      userID: user['userid'],
      username: user['username'],
      email: user['email'],
      location: user['location'],
      verificationStatus: user['verificationstatus'],
      rating: user['rating'],
      isDonor: user['isdonor'],
      picture: user['picture'],
      phoneNumber: user['phonenumber'],
    );
  }

  @override
  String toString() {
    return "{userid: $userID, username: $username, email: $email,  location: $location, verificationstatus: $verificationStatus,  rating: $rating, isDonor: $isDonor, picture: $picture }";
  }
}
