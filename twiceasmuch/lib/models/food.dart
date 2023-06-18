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
  final int? quantity;
  final FoodState state;
  final num? discountPrice;
  final bool sold;

  AppUser? donor;

  Food(
      {this.name,
      this.donorID,
      this.foodID,
      this.uploadedAt,
      this.expiryDate,
      this.location,
      this.quantity,
      this.image,
      required this.state,
      this.discountPrice,
      this.sold = false});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['name'],
        donorID: json['donorid'],
        foodID: json['foodid'],
        image: json['image'],
        uploadedAt: DateFormat('yyyy-MM-dd HH:mm:ss')
            .parseUTC(json['uploadedAt'])
            .toLocal(),
        expiryDate:
            DateFormat('yyyy-MM-dd').parseUTC(json['expirydate']).toLocal(),
        quantity: json['quantity'],
        location: json['location'],
        discountPrice: json['discountprice'],
        state: FoodState.fromString(json['state']),
        sold: json['sold']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "donorid": donorID,
      "foodid": foodID,
      "image": image,
      "uploadedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(
        (uploadedAt ?? DateTime.now()).toUtc(),
      ),
      "expirydate": DateFormat('yyyy-MM-dd').format(
        (expiryDate ?? DateTime.now()).toUtc(),
      ),
      "quantity": quantity,
      "location": location,
      "discountprice": discountPrice,
      "state": state.toString(),
      "sold": sold
    };
  }
}
