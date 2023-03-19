import 'package:firebase_app/Helper/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/global.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: signInKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    "Sign IN",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: Global.signInEmail,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter the Email";
                      }
                      if (!RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(val)) {
                        return "Enter Valid a Email";
                      }
                    },
                    style: GoogleFonts.poppins(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      errorStyle: GoogleFonts.poppins(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter the Password";
                      }
                      if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(val)) {
                        return "Please Enter a Valid password";
                      }
                    },
                    controller: Global.signInPass,
                    obscureText: true,
                    obscuringCharacter: "*",
                    style: GoogleFonts.poppins(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      hintText: "Password",
                      errorStyle: GoogleFonts.poppins(),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  (Global.signIn == true)
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            borderRadius: BorderRadius.circular(30),
                            onPressed: () {
                              if (signInKey.currentState!.validate()) {
                                AuthHelper.instance.authSignIn(context, setState);
                              }
                            },
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                      ),
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'signUp');
                        Global.signInEmail.clear();
                        Global.signInPass.clear();
                      },
                      child: Text(
                        "Sign Up Account",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
