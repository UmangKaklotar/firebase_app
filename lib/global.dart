import 'package:firebase_auth/firebase_auth.dart';

class Global {
  static bool isLogin = false;
  static User? user;
  static String signInEmail = "",
      signInPass = "",
      signUpEmail = "",
      signUpPass = "";
}
