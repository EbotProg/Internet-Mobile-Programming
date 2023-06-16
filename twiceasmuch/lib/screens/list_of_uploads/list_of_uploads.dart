import 'package:flutter/material.dart';
import 'package:food_donation_platform_app/screens/food_item.dart';
import 'package:food_donation_platform_app/screens/uploaded_food.dart';

class ListOfUploads extends StatelessWidget {
  const ListOfUploads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text("My uploads"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return UploadedFood();
          }),
    );
  }
}
