import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: signInKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
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
                    hintText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    errorStyle: GoogleFonts.poppins(),
                  ),
                  onSaved: (val) {
                    setState(() {
                      Global.signInEmail = val.toString();
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintText: "Password",
                    errorStyle: GoogleFonts.poppins(),
                  ),
                  onSaved: (val) {
                    setState(() {
                      Global.signInPass = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                (Global.isLogin == true)
                    ? const Center(child: CircularProgressIndicator())
                    : CupertinoButton.filled(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderRadius: BorderRadius.circular(30),
                        onPressed: () async {
                          if (signInKey.currentState!.validate()) {
                            signInKey.currentState!.save();
                            try {
                              setState(() {
                                Global.isLogin = true;
                              });

                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
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
                                    content:
                                        Text("No user found for that email."),
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
                        },
                        child: Text("Sign in", style: GoogleFonts.poppins(),),
                      ),
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'signUp'),
                  child: Text(
                    "Sign Up Account",
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
