import 'package:flutter/material.dart';
import 'package:twiceasmuch/screens/list_of_uploads/uploaded_food.dart';

class ListOfUploads extends StatelessWidget {
  const ListOfUploads({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const UploadedFood();
        });
  }
}
