import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/screens/auth_start_screen.dart';
import 'package:twiceasmuch/screens/home_screen.dart';

class AuthStateManager extends StatelessWidget {
  const AuthStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const AuthStartScreen();
        }
      },
    );
  }
}
