import 'package:firebase_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Password"),
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
                        onPressed: () async {
                          Global.isLogin = true;
                          if (signUpKey.currentState!.validate()) {
                            signUpKey.currentState!.save();
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: Global.signUpEmail,
                                password: Global.signUpPass,
                              );

                              User? user;
                              user = credential.user;
                              print("Register User : $user");

                              Navigator.pushNamed(context, 'home',
                                  arguments: Global.signUpEmail);
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
                                  SnackBar(
                                    content: Text("The account already exists for that email."),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: const Text("Sign UP"),
                      ),
                const SizedBox(
                  height: 50,
                ),
                CupertinoButton.filled(
                  onPressed: () {
                    AuthHelper().authGoogle();
                  },
                  child: const Text("Google Login"),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Already Exit An Account",
                    style: TextStyle(
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
