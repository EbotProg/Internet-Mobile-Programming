import 'package:flutter/material.dart';
import 'package:food_donation_platform/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Donation Platform',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff20B970)),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
