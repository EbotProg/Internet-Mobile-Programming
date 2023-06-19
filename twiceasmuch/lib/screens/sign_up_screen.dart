import 'package:flutter/material.dart';
import 'package:twiceasmuch/auth/user_auth.dart';
import 'package:twiceasmuch/enums/user_type.dart';
import 'package:twiceasmuch/models/user.dart';
import 'package:twiceasmuch/screens/home_screen.dart';
import 'package:twiceasmuch/screens/login_screen.dart';
import 'package:twiceasmuch/utilities/sign_up_utils.dart';
import 'package:twiceasmuch/utilities/snackbar_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserType? userType;
  bool registering = false;

  @override
  void initState() {
    nameSignUpController = TextEditingController();
    emailSignUpController = TextEditingController();
    locationController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordSignUpController = TextEditingController();
    confirmPasswordSignUpController = TextEditingController();

    nameSignUpFocus = FocusNode();
    emailSignUpFocus = FocusNode();
    locationSignUpFocus = FocusNode();
    phoneNumberSignUpFocus = FocusNode();
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
    locationController!.dispose();
    phoneNumberController!.dispose();
    emailSignUpFocus!.dispose();
    nameSignUpFocus!.dispose();
    passwordSignUpFocus!.dispose();
    confirmPasswordSignUpFocus!.dispose();
    locationSignUpFocus!.dispose();
    phoneNumberSignUpFocus!.dispose();

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
              DropdownButtonFormField<UserType>(
                value: userType,
                hint: const Text('Select User Type'),
                items: [
                  ...UserType.values.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.displayString()),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    userType = value;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text('User Type'),
                  border: OutlineInputBorder(),
                  fillColor: Color(0xffECECEC),
                ),
                validator: (input) {
                  if (input == null) {
                    return 'please select your user type';
                  }

                  return null;
                },
                onSaved: (_) {
                  nameSignUpFocus!.requestFocus();
                },
              ),
              const SizedBox(height: 20),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailSignUpController,
                focusNode: emailSignUpFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onFieldSubmitted: (_) {
                  phoneNumberSignUpFocus!.requestFocus();
                },
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
              if (userType == UserType.donor) ...[
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneNumberController,
                  focusNode: phoneNumberSignUpFocus,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Please enter a phone number';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Phone number'),
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffECECEC),
                  ),
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (_) {
                    locationSignUpFocus!.requestFocus();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: locationController,
                  focusNode: locationSignUpFocus,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onFieldSubmitted: (_) {
                    passwordSignUpFocus!.requestFocus();
                  },
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Please enter a location';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Location'),
                    border: OutlineInputBorder(),
                    fillColor: Color(0xffECECEC),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ],
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordSignUpController,
                focusNode: passwordSignUpFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  FocusScope.of(context).requestFocus();
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
                  onPressed: registering
                      ? () {}
                      : () async {
                          if (signUpKey.currentState!.validate()) {
                            setState(() {
                              registering = true;
                            });
                            final result = await UserAuthentication()
                                .signUpEmailAndPassword(
                              AppUser(
                                email: emailSignUpController!.text,
                                location: userType == UserType.donor
                                    ? locationController!.text
                                    : null,
                                phoneNumber: userType == UserType.donor
                                    ? phoneNumberController!.text
                                    : null,
                                picture: null,
                                rating: null,
                                userType: userType!,
                                username: nameSignUpController!.text,
                                // verificationStatus: true,
                              ),
                              passwordSignUpController!.text,
                            );

                            if (result == null) {
                              snackbarError(
                                title: 'Registration error',
                                context: context,
                              );
                              setState(() {
                                registering = false;
                              });
                              return;
                            }
                            snackbarSuccessful(
                              title: 'Registration successful',
                              context: context,
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
                  child: registering
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
