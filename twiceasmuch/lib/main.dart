import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nkatdbgebctuvkmxknve.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5rYXRkYmdlYmN0dXZrbXhrbnZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODU3MDk3MDMsImV4cCI6MjAwMTI4NTcwM30.tQJ-lp27YJmclWJ5DAcn2BWaz_yIMnrZYQbhWcUmcFQ',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Donation Platform',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff20B970),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthStateManager(),
    );
  }
}
