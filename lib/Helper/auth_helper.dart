import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Utils/global.dart';

class AuthHelper {
  authSignIn(context, setState) async {
    try {
      setState(() {
        Global.signIn = true;
      });

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Global.signInEmail.text,
        password: Global.signInPass.text,
      );

      Global.user = credential.user;
      print("Register User : ${Global.user}");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        'home',
      );

      setState(() {
        Global.signIn = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        Global.signIn = false;
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
        Global.signUp = true;
      });

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Global.signUpEmail.text,
        password: Global.signUpPass.text,
      );

      Global.user = credential.user;
      print("Register User : ${Global.user}");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        'home',
      );

      setState(() {
        Global.signUp = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        Global.signUp = false;
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
