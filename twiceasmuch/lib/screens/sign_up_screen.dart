import 'package:flutter/material.dart';
import 'package:twiceasmuch/screens/home_screen.dart';
import 'package:twiceasmuch/screens/login_screen.dart';
import 'package:twiceasmuch/utilities/sign_up_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String dropDownValue = '';

  @override
  void initState() {
    nameSignUpController = TextEditingController();
    emailSignUpController = TextEditingController();
    passwordSignUpController = TextEditingController();
    confirmPasswordSignUpController = TextEditingController();

    nameSignUpFocus = FocusNode();
    emailSignUpFocus = FocusNode();
    emailSignUpFocus = FocusNode();
    emailSignUpFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailSignUpController!.dispose();
    nameSignUpController!.dispose();
    passwordSignUpController!.dispose();
    confirmPasswordSignUpController!.dispose();
    emailSignUpFocus!.dispose();
    nameSignUpFocus!.dispose();
    passwordSignUpFocus!.dispose();
    confirmPasswordSignUpFocus!.dispose();

    super.dispose();
  }

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
            key: signUpKey,
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
                controller: nameSignUpController,
                focusNode: nameSignUpFocus,
                onFieldSubmitted: (_) {
                  emailSignUpFocus!.requestFocus();
                },
                validator: (input) {
                  if (input == null) {
                    return 'please enter your name or org name';
                  } else if (input.length < 3) {
                    return 'length should be at least 3';
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffECECEC),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailSignUpController,
                focusNode: emailSignUpFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(input)) {
                    return "please enter a valid email";
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffECECEC),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: dropDownValue,
                items: const [
                  DropdownMenuItem(
                    value: 'user',
                    child: Text("user"),
                  ),
                  DropdownMenuItem(value: 'donor', child: Text("donor")),
                ],
                onChanged: (value) {
                  dropDownValue = value!;
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordSignUpController,
                focusNode: passwordSignUpFocus,
                onFieldSubmitted: (_) {
                  confirmPasswordSignUpFocus!.requestFocus();
                },
                validator: (input) {
                  if (input == null) {
                    return 'please enter your password';
                  } else if (input.length < 8) {
                    return 'length should be at least 8 characters';
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Password'),
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffECECEC),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordSignUpController,
                focusNode: confirmPasswordSignUpFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (input) {
                  if (input == null) {
                    return 'please renter your password';
                  } else if (input != passwordSignUpController!.text) {
                    return 'passwords don\'t match';
                  }
                },
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
                    if (signUpKey.currentState!.validate()) {
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
      ),
    );
  }
}
