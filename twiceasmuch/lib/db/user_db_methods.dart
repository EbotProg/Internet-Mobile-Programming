import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/models/user.dart';

class UserDBMethods {
  final supabase = Supabase.instance;

  Future<void> insertUser(AppUser user) async {
    try {
      await supabase.client.from('users').insert(user.toJson());
      return;
    } on PostgrestException catch (e) {
      print(e);
      return;
    }
  }

  Future<AppUser?> getCurrenUser() async {
    try {
      final user = await supabase.client
          .from('users')
          .select()
          .eq('userid', supabase.client.auth.currentUser!.id)
          .single() as Map<String, dynamic>;
      return AppUser.fromJson(user);
    } on PostgrestException catch (e) {
      print(e);
      return null;
    }
  }

  Future<AppUser?> getUser(String id) async {
    try {
      final user = await supabase.client
          .from('users')
          .select()
          .eq('userid', id)
          .single() as Map<String, dynamic>;
      return AppUser.fromJson(user);
    } on PostgrestException catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<AppUser>> getUsers() async {
    try {
      final userMaps = await supabase.client
          .from('users')
          .select<List<Map<String, dynamic>>>();

      final users = userMaps.map((e) => AppUser.fromJson(e)).toList();

      return users;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppUser>> getUsersPerIds(List<String> ids) async {
    try {
      final userMaps = await supabase.client
          .from('users')
          .select<List<Map<String, dynamic>>>()
          .in_('userid', ids);

      final users = userMaps.map((e) => AppUser.fromJson(e)).toList();

      return users;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateUser(AppUser user) async {
    try {
      if (user.imageFile != null) {
        user.picture = await _uploadImage(user.imageFile!);
      }

      await supabase.client
          .from('users')
          .update(user.toJson())
          .eq('userid', user.userID);
      return;
    } on PostgrestException catch (e) {
      print(e);
    }
  }

  Future<String?> _uploadImage(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      final fileName = image.name;
      await supabase.client.storage
          .from('userImages')
          .uploadBinary(fileName, bytes);
      final imageUrl = await supabase.client.storage
          .from('userImages')
          .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);
      return imageUrl;
    } on StorageException catch (e) {
      print(e);
      return null;
    }
  }
}
