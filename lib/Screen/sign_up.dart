import 'package:firebase_app/Helper/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/global.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: signUpKey,
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
                    height: 130,
                  ),
                  const Text(
                    "Sign UP",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: Global.signUpEmail,
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      errorStyle: GoogleFonts.poppins(),
                      hintText: "Email",
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
                    controller: Global.signUpPass,
                    obscureText: true,
                    obscuringCharacter: "*",
                    style: GoogleFonts.poppins(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      errorStyle: GoogleFonts.poppins(),
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  (Global.signUp == true)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            borderRadius: BorderRadius.circular(30),
                            onPressed: () {
                              if (signUpKey.currentState!.validate()) {
                                AuthHelper.instance.authSignUp(context, setState);
                              }
                            },
                            child: Text(
                              "Sign UP",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                      ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      borderRadius: BorderRadius.circular(30),
                      onPressed: () {
                        AuthHelper.instance.authGoogle(context);
                      },
                      child: Text(
                        "Google Login",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, 'state', (route) => false);
                        Global.signUpEmail.clear();
                        Global.signUpPass.clear();
                      },
                      child: Text(
                        "Already Exists An Account",
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
