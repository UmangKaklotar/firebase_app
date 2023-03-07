import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'global.dart';

class AuthHelper {
  authSignIn(context, setState) async {
    try {
      setState(() {
        Global.isLogin = true;
      });

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Global.signInEmail,
        password: Global.signInPass,
      );

      Global.user = credential.user;
      print("Register User : ${Global.user}");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        'home',
      );

      setState(() {
        Global.isLogin = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        Global.isLogin = false;
      });

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for that email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong password provided."),
          ),
        );
      }
    }
  }

  authSignUp(context, setState) async {
    try {
      setState(() {
        Global.isLogin = true;
      });

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Global.signUpEmail,
        password: Global.signUpPass,
      );

      Global.user = credential.user;
      print("Register User : ${Global.user}");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        'home',
      );

      setState(() {
        Global.isLogin = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        Global.isLogin = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The account already exists for that email."),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  authGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );
    final google = await FirebaseAuth.instance.signInWithCredential(credential);
    Global.user = google.user;
    print(Global.user);
    return google;
  }
}
