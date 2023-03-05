import 'package:firebase_app/home_screen.dart';
import 'package:firebase_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyApp(),
        'signUp': (context) => const SignUp(),
        'home': (context) => const HomeScreen(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Password"),
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
                    ? Center(child: const CircularProgressIndicator())
                    : CupertinoButton.filled(
                        onPressed: () async {
                          Global.isLogin = true;
                          if (signInKey.currentState!.validate()) {
                            signInKey.currentState!.save();
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: Global.signInEmail,
                                password: Global.signInPass,
                              );

                              User? user;
                              user = credential.user;
                              print("Register User : $user");

                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(
                              //   SnackBar(
                              //     content: Text("Sign In Successfully"),
                              //   ),
                              // ));
                              Navigator.pushNamed(context, 'home',
                                  arguments: Global.signInEmail);
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
                                  SnackBar(
                                    content: Text("No user found for that email."),
                                  ),
                                );
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided.');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Wrong password provided."),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: const Text("Sign in"),
                      ),
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'signUp'),
                  child: const Text(
                    "Sign Up Account",
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
