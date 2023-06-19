import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/screens/list_of_uploads/uploaded_food.dart';
import 'package:twiceasmuch/screens/upload_food.dart';

class ListOfUploads extends StatefulWidget {
  const ListOfUploads({super.key});

  @override
  State<ListOfUploads> createState() => _ListOfUploadsState();
}

class _ListOfUploadsState extends State<ListOfUploads> {
  final db = FoodDBMethods();

  List<Food> foods = [];

  Future<void> getUploads() async {
    foods = await db
        .getUploadedFoods(Supabase.instance.client.auth.currentUser!.id);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    getUploads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: getUploads,
        child: foods.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  color: Color(0xff292E2A),
                ),
              )
            : foods.first.state == FoodState.none
                ? const Center(
                    child: Text("No Uploads Yet!"),
                  )
                : ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return UploadedFood(
                          food: foods[index],
                          editFood: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => UploadFoodScreen(
                                shouldEdit: true,
                                food: foods[index],
                              ),
                            ));
                          },
                          deleteFood: () async {
                            await db.deleteFood(foods[index]);
                            getUploads();
                          });
                    }));
  }
}
