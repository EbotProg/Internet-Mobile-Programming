import 'package:image_picker/image_picker.dart';
import 'package:twiceasmuch/enums/user_type.dart';

class AppUser {
  AppUser({
    this.userID,
    this.email,
    this.username,
    this.location,
    this.verificationStatus = false,
    this.rating,
    this.userType = UserType.user,
    this.picture,
    this.phoneNumber,
  });

  String? userID;
  String? username;
  String? email;
  String? location;
  bool verificationStatus;
  double? rating;
  UserType userType;
  String? picture;
  String? phoneNumber;

  XFile? imageFile;

  Map<String, dynamic> toJson() {
    return {
      'userid': userID,
      'username': username,
      'email': email,
      'location': location,
      'verificationstatus': verificationStatus,
      'rating': rating,
      'isdonor': userType == UserType.donor,
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
      userType: user['isdonor'] ? UserType.donor : UserType.user,
      picture: user['picture'],
      phoneNumber: user['phonenumber'],
    );
  }

  @override
  String toString() {
    return "{userid: $userID, username: $username, email: $email,  location: $location, verificationstatus: $verificationStatus,  rating: $rating, isDonor: ${userType == UserType.donor}, picture: $picture }";
  }
}
