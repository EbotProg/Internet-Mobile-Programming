import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/models/food.dart';

class FoodService {
  final supabaseInstance = Supabase.instance;

  //insert users to database
  Future<List<Food>> getFoods() async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .order('uploadedAt');
      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Food>> getTrendingFoods() async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .order('uploadedAt');
      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Food>> getRecommendedFoods() async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .order('uploadedAt', ascending: true);
      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Food>> getUploadedFoods(String userId) async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .contains('donorID', userId)
          .order('uploadedAt');
      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Food>> searchFoods({
    required String value,
    required FoodState foodState,
  }) async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .textSearch('name', value)
          .contains('state', foodState.toString())
          .order('uploadedAt');

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

    Future<List<Food>> getFoodsPerIds(List<String> ids) async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .in_('foodID', ids)
          .order('uploadedAt');

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
