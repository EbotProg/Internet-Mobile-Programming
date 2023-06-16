import 'package:flutter/material.dart';

import 'food_screen.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FoodScreen(),
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
                child: Image.asset(
                  'assets/Rectangle 1.png',
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
                      'Spaghetti',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'by Larry',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '10 mins ago',
                          style: TextStyle(
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
