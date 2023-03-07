import 'package:firebase_app/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: signUpKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 150,
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
                  controller: emailController,
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
                  onSaved: (val) {
                    setState(() {
                      Global.signUpEmail = val.toString();
                    });
                  },
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
                  controller: passController,
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    errorStyle: GoogleFonts.poppins(),
                    hintText: "Password",
                  ),
                  onSaved: (val) {
                    setState(() {
                      Global.signUpPass = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                (Global.isLogin == true)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CupertinoButton.filled(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderRadius: BorderRadius.circular(30),
                        onPressed: () {
                          if (signUpKey.currentState!.validate()) {
                            signUpKey.currentState!.save();
                            AuthHelper().authSignUp(context, setState);
                          }
                        },
                        child: Text(
                          "Sign UP",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                const SizedBox(
                  height: 50,
                ),
                CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {
                    AuthHelper().authGoogle();
                  },
                  child: Text(
                    "Google Login",
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Already Exists An Account",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
