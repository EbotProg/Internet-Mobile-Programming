import 'package:flutter/material.dart';
import 'package:twiceasmuch/auth/user_auth.dart';
import 'package:twiceasmuch/screens/home_screen.dart';
import 'package:twiceasmuch/screens/sign_up_screen.dart';
import 'package:twiceasmuch/utilities/sign_in_utils.dart';
import 'package:twiceasmuch/utilities/snackbar_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = UserAuthentication();
  bool isloading = false;
  @override
  void initState() {
    emailSignInController = TextEditingController();
    passwordSignInController = TextEditingController();

    passwordSignInFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailSignInController!.dispose();
    passwordSignInController!.dispose();
    passwordSignInFocus!.dispose();
    super.dispose();
  }

  bool isLoading = false;

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
          child: Form(
            key: signInKey,
            child: Column(children: [
              const SizedBox(height: 30),
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailSignInController,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(input)) {
                    return "please enter a valid email";
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  passwordSignInFocus!.requestFocus();
                },
                decoration: const InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffECECEC),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordSignInController,
                focusNode: passwordSignInFocus,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Password'),
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
                  onPressed: isLoading
                      ? () {}
                      : () async {
                          if (signInKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            final result = await UserAuthentication()
                                .signInWithEmailAndPassword(
                              emailSignInController!.text,
                              passwordSignInController!.text,
                            );

                            if (result == null) {
                              snackbarError(
                                title: 'Incorrect credentials',
                                context: context,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            snackbarSuccessful(
                              title: 'Login successful',
                              context: context,
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff20B970),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        )
                      : const Text(
                          'Login',
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
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Register',
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
      ),
    );
  }
}
