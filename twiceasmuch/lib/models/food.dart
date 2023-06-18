import 'package:intl/intl.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/models/user.dart';

class Food {
  final String? name;
  final String? donorID;
  final int? foodID;
  final String? image;
  final DateTime? uploadedAt;
  final DateTime? expiryDate;
  final String? location;
  final int? quanity;
  final FoodState state;
  final num? discountPrice;

  User? donor;

  Food({
    this.name,
    this.donorID,
    this.foodID,
    this.uploadedAt,
    this.expiryDate,
    this.location,
    this.quanity,
    this.image,
    required this.state,
    this.discountPrice,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      donorID: json['donorID'],
      foodID: json['foodID'],
      image: json['image'],
      uploadedAt: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parseUTC(json['uploadedAt'])
          .toLocal(),
      expiryDate:
          DateFormat('yyyy-MM-dd').parseUTC(json['expiryDate']).toLocal(),
      quanity: json['quanity'],
      location: json['location'],
      discountPrice: json['discountPrice'],
      state: FoodState.fromString(json['state']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "donorID": donorID,
      "foodID": foodID,
      "image": image,
      "uploadedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (uploadedAt ?? DateTime.now()).toUtc(),
      ),
      "expiryDate": DateFormat('yyyy-MM-dd').format(
        (expiryDate ?? DateTime.now()).toUtc(),
      ),
      "quanity": quanity,
      "location": location,
      "discountPrice": discountPrice,
      "state": state.toString(),
    };
  }
}
