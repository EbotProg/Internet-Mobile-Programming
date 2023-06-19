import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/models/user.dart';

class UserAuthentication {
  final userDB = UserDBMethods();
  final supabaseInstance = Supabase.instance;

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await supabaseInstance.client.auth
        .signInWithPassword(email: email, password: password);

    final userId = response.user?.id;
    if (userId == null) {
      return null;
    }

    //use "userId" to query db and get user then return this user
    final appUser = await userDB.getUser(userId);
    return appUser;
  }

  Future<String?> signUpEmailAndPassword(
      AppUser appuser, String password) async {
    final response = await supabaseInstance.client.auth
        .signUp(email: appuser.email, password: password);

    final userId = response.user?.id;

    if (userId == null) {
      return null;
    }
    print("success");
    return userId;
  }

  Future<void> signOut() async {
    await supabaseInstance.client.auth.signOut();
    return;
  }
}
