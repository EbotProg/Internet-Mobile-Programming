import 'package:flutter/material.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/widgets/food_item.dart';
import 'package:twiceasmuch/widgets/recent_food_widget.dart';

class StarterScreen extends StatefulWidget {
  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  List<Food> trending = [];
  List<Food> foods = [];
  List<Food> recommended = [];
  List<Food> searched = [];
  bool loading = true;
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    init();
  }

  Future<void> init() async {
    setState(() {
      loading = true;
    });

    final fetches = [
      FoodDBMethods().getTrendingFoods(),
      FoodDBMethods().getRecommendedFoods(),
      FoodDBMethods().getFoods(),
    ];

    final results = await Future.wait(fetches);

    setState(() {
      trending = results[0];
      foods = results[2];
      recommended = results[1];
      loading = false;
    });
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: init,
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Hello ${globalUser?.username ?? 'there'},',
                  style: const TextStyle(
                    color: Color(0xff20B970),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'What do you want to buy today?',
                  style: TextStyle(
                    color: Color(0xff9A9A9A),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: searchController,
                  onChanged: (val) async {
                    searched = [];
                    setState(() {});
                    searched = await FoodDBMethods().searchFoods(
                        value: val.split(' ').first, foodState: FoodState.raw);
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    label: Text('Search Food'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              searchController!.text.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Trending Meals',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 7.5),
                                ...List.generate(
                                  trending.length,
                                  (i) => FoodItem(
                                    food: trending[i],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Recent Meals',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        ...List.generate(
                          trending.length,
                          (i) => RecentMealFood(
                            food: trending[i],
                          ),
                        ),
                      ],
                    )
                  : searched.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                                searched.length,
                                (index) =>
                                    RecentMealFood(food: searched[index]))
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }
}
