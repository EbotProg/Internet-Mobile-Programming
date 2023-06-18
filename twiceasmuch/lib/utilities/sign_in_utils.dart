import 'package:flutter/material.dart';

TextEditingController? emailSignInController;
TextEditingController? passwordSignInController;

FocusNode? emailSignInFocus;
FocusNode? passwordSignInFocus;

final signInKey = GlobalKey<FormState>();
