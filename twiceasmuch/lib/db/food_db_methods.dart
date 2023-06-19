import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/models/food.dart';

class FoodDBMethods {
  final supabaseInstance = Supabase.instance;

  Future<List<Food>> getFoods() async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .order('uploadedAt');
      final users = await UserDBMethods().getUsers();

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      for (var food in foods) {
        food.donor = users.firstWhere(
          (user) => user.userID == food.donorID,
        );
      }
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
          .order('uploadedAt', ascending: true);
      final users = await UserDBMethods().getUsers();

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      for (var food in foods) {
        food.donor = users.firstWhere(
          (user) => user.userID == food.donorID,
        );
      }
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
      final users = await UserDBMethods().getUsers();

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      for (var food in foods) {
        food.donor = users.firstWhere(
          (user) => user.userID == food.donorID,
        );
      }
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
          .contains('donorid', userId)
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

      final users = await UserDBMethods().getUsers();

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      for (var food in foods) {
        food.donor = users.firstWhere(
          (user) => user.userID == food.donorID,
        );
      }
      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Food?> getFoodPerId(String id) async {
    try {
      final foodMap = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .contains('foodid', id)
          .single() as Map<String, dynamic>;

      final food = Food.fromJson(foodMap);

      final user = await UserDBMethods().getUser(food.donorID!);

      food.donor = user;

      return food;
    } on PostgrestException catch (e) {
      print(e);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Food>> getFoodsPerIds(List<String> ids) async {
    try {
      final foodMaps = await supabaseInstance.client
          .from('food')
          .select<List<Map<String, dynamic>>>()
          .in_('foodid', ids)
          .order('uploadedAt');

      final users = await UserDBMethods().getUsers();

      final foods = foodMaps.map((e) => Food.fromJson(e)).toList();

      for (var food in foods) {
        food.donor = users.firstWhere(
          (user) => user.userID == food.donorID,
        );
      }
      return foods;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteFood(Food food) async {
    try {
      if (food.imageFile != null) {
        food.image = await _uploadImage(food.imageFile!);
      }

      await supabaseInstance.client
          .from('food')
          .delete()
          .eq('foodid', food.foodID);
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> editFood(Food food) async {
    try {
      if (food.imageFile != null) {
        food.image = await _uploadImage(food.imageFile!);
      }

      await supabaseInstance.client
          .from('food')
          .update(food.toJson())
          .eq('foodid', food.foodID);
    } on PostgrestException catch (e) {
      print(e);
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<String?> uploadFood(Food food) async {
    try {
      if (food.imageFile != null) {
        food.image = await _uploadImage(food.imageFile!);
      }

      await supabaseInstance.client.from('food').insert(food.toJson());
      print('success');
      return 'successful upload';
    } on PostgrestException catch (e) {
      print(e);
      return e.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> _uploadImage(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      //final fileExt = image.path.split('.').last;
      final fileName = image.name;
      await supabaseInstance.client.storage
          .from('foodImages')
          .uploadBinary(fileName, bytes);
      final imageUrl = await supabaseInstance.client.storage
          .from('foodImages')
          .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);
      return imageUrl;
    } on StorageException catch (e) {
      print(e);
      return null;
    }
  }
}
