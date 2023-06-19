import 'package:flutter/material.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/widgets/dialog.dart';

class UploadedFood extends StatelessWidget {
  const UploadedFood({super.key, this.food, this.deleteFood, this.editFood});
  final Function? deleteFood;
  final Function? editFood;
  final Food? food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  image: food!.image == null
                      ? const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/eru.png'),
                        )
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(food!.image!),
                        )),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff313131),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food!.name!,
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
                        '${food!.discountPrice!.toString()} fcfa',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MyDialog(
                                        title: 'Delete Food',
                                        description:
                                            'This will delete this item from the app',
                                        onContinue: () {
                                          deleteFood!();
                                        },
                                        continueText: 'Delete',
                                        continueColor: Colors.red);
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              editFood!();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  food!.sold
                      ? const Text(
                          'Sold',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'Not sold',
                          style: TextStyle(color: Colors.red),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
