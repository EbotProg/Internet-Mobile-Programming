import 'package:flutter/material.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/screens/food_screen.dart';
import 'package:twiceasmuch/utilities/date_diff.dart';

class RecentMealFood extends StatelessWidget {
  final Food food;
  const RecentMealFood({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xff313131),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        // width: double.infinity,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                food.image ?? '',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
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
}
