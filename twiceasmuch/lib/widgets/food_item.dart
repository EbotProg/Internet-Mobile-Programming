import 'package:flutter/material.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/utilities/date_diff.dart';

import '../screens/food_screen.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  const FoodItem({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FoodScreen(
                food: food,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7.5),
          decoration: BoxDecoration(
            color: const Color(0xff313131),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          width: 200,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(
                  food.image ?? '',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'by ${food.donor?.username ?? ''}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          food.uploadedAt!.currentTimelapseString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
