import 'package:flutter/material.dart';
import 'package:twiceasmuch/screens/login_screen.dart';
import 'package:twiceasmuch/screens/sign_up_screen.dart';

class AuthStartScreen extends StatelessWidget {
  const AuthStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff292E2A), Color(0xff20B970)],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                tileMode: TileMode.clamp,
              ),
              // color: const Color(0xff292E2A),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "2ICEASMUCH",
                      style: const TextStyle(
                        fontFamily: 'DmSans',
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ).copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      "   By Tapping Create Account or Sign in you\nagree to our Terms.Learn how we process your\n data in our Privacy Policy and Cookies Policy",
                      style: const TextStyle(
                        fontFamily: 'DmSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ).copyWith(
                        fontSize: 14,
                        color: Colors.white38,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        //NextScreen emailScreen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontFamily: 'DmSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        //next screen sign in screen
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                        height: 55,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: const TextStyle(
                              fontFamily: 'DmSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ).copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ],
    ));
  }
}
