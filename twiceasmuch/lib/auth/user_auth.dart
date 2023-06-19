import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/global.dart';
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
    globalUser = appUser;
    return appUser;
  }

  Future<AppUser?> signUpEmailAndPassword(
      AppUser appuser, String password) async {
    final response = await supabaseInstance.client.auth
        .signUp(email: appuser.email, password: password);

    appuser.userID = response.user?.id;

    await UserDBMethods().insertUser(appuser);

    final user = await userDB.getUser(appuser.userID!);
    globalUser = user;
    return user;
  }

  Future<void> signOut() async {
    await supabaseInstance.client.auth.signOut();
    globalUser = null;
    return;
  }
}
