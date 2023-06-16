import 'package:flutter/material.dart';
import 'package:food_donation_platform_app/screens/home_screen.dart';
import 'package:food_donation_platform_app/screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Image.asset(
        'assets/Rectangle 1.png',
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: height - 250,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 30),
            const Text(
              'Register',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Username'),
                border: OutlineInputBorder(),
                fillColor: Color(0xffECECEC),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
                fillColor: Color(0xffECECEC),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
                fillColor: Color(0xffECECEC),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Confirm Password'),
                border: OutlineInputBorder(),
                fillColor: Color(0xffECECEC),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff20B970),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
