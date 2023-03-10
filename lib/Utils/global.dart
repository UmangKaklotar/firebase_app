import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Global {
  static bool signIn = false, signUp = false;
  static List userData = [];
  static User? user;
  static TextEditingController signInEmail = TextEditingController(),
      signInPass = TextEditingController(),
      signUpEmail = TextEditingController(),
      signUpPass = TextEditingController(),
      name = TextEditingController(),
      age = TextEditingController();
}
