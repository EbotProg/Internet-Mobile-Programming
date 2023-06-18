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

  Future<void> updateUser(Map<String, dynamic> userData, String id) async {
    try {
      await supabase.client.from('users').update(userData).eq('userid', id);
      return;
    } on PostgrestException catch (e) {
      print(e);
    }
  }
}
