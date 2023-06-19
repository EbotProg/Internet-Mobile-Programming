import 'package:flutter/material.dart';
import 'package:twiceasmuch/auth/user_auth.dart';
import 'package:twiceasmuch/enums/user_status.dart';
import 'package:twiceasmuch/models/user.dart';
import 'package:twiceasmuch/screens/home_screen.dart';
import 'package:twiceasmuch/screens/login_screen.dart';
import 'package:twiceasmuch/utilities/sign_up_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var dropDownValue = UserStatus.none;
  bool isloading = false;
  final auth = UserAuthentication();

  @override
  void initState() {
    nameSignUpController = TextEditingController();
    emailSignUpController = TextEditingController();
    passwordSignUpController = TextEditingController();
    confirmPasswordSignUpController = TextEditingController();

    nameSignUpFocus = FocusNode();
    emailSignUpFocus = FocusNode();
    passwordSignUpFocus = FocusNode();
    confirmPasswordSignUpFocus = FocusNode();

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
                  return null;
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
                  return null;
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
                decoration: const InputDecoration(border: OutlineInputBorder()),
                value: dropDownValue,
                validator: (val) {
                  if (val == UserStatus.none) {
                    return 'Please select status';
                  }
                  return null;
                },
                items: const [
                  DropdownMenuItem(
                    value: UserStatus.none,
                    child: Text("None"),
                  ),
                  DropdownMenuItem(
                    value: UserStatus.user,
                    child: Text("user"),
                  ),
                  DropdownMenuItem(
                      value: UserStatus.donor, child: Text("donor")),
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
                  return null;
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
                  confirmPasswordSignUpFocus!.unfocus();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (input) {
                  if (input == null) {
                    return 'please renter your password';
                  } else if (input != passwordSignUpController!.text) {
                    return 'passwords don\'t match';
                  }
                  return null;
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
                  onPressed: () async {
                    if (signUpKey.currentState!.validate()) {
                      setState(() {
                        isloading = true;
                      });
                      await auth.signUpEmailAndPassword(
                          AppUser(
                              email: emailSignUpController!.text,
                              username: nameSignUpController!.text),
                          passwordSignUpController!.text);
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
                  child: isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        )
                      : const Text(
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
