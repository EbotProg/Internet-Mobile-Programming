class AppUser {
  AppUser(
      {this.id,
      this.email,
      this.name,
      this.location,
      this.verificationStatus = false,
      this.rating,
      this.isdonor = false,
      this.picture});
  String? id;
  String? name;
  String? email;
  String? location;
  bool verificationStatus;
  double? rating;
  bool isdonor;
  String? picture;

  Map<String, dynamic> toJson() {
    return {
      'userid': id,
      'username': name,
      'email': email,
      'location': location,
      'verificationstatus': verificationStatus,
      'rating': rating,
      'isdonor': isdonor,
      'picture': picture
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> user) {
    return AppUser(
      id: user['userid'],
      name: user['username'],
      email: user['email'],
      location: user['location'],
      verificationStatus: user['verificationstatus'],
      rating: user['rating'],
      isdonor: user['isdonor'],
      picture: user['picture'],
    );
  }

  @override
  String toString() {
    return "{userid: $id, username: $name, email: $email,  location: $location, verificationstatus: $verificationStatus,  rating: $rating, isdonor: $isdonor, picture: $picture }";
  }
}
