import 'package:firebase_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  String signUpEmail = "", signUpPass = "";
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
                const SizedBox(height: 150,),
                const Text("Sign UP", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,),),
                const SizedBox(height: 50,),
                TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if(val!.isEmpty) {
                      return "Please Enter the Email";
                    }
                    if(!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val)) {
                      return "Enter Valid a Email";
                    }
                  },
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email"
                  ),
                  onSaved: (val){
                    setState(() {
                      signUpEmail = val.toString();
                    });
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  validator: (val){
                    if(val!.isEmpty) {
                      return "Please Enter the Password";
                    }
                    if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) {
                      return "Please Enter a Valid password";
                    }
                  },
                  controller: passController,
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password"
                  ),
                  onSaved: (val){
                    setState(() {
                      signUpPass = val.toString();
                    });
                  },
                ),
                const SizedBox(height: 100,),
                CupertinoButton.filled(
                  onPressed: () async {
                      if(signUpKey.currentState!.validate()) {
                        signUpKey.currentState!.save();
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: signUpEmail, password: signUpPass,
                          );
                          Navigator.pushNamed(context, 'home', arguments: signUpEmail);
                        } catch(e) {
                          print(e);
                        }
                      }
                  },
                  child: const Text("Sign UP"),
                ),
                const SizedBox(height: 50,),
                CupertinoButton.filled(
                  onPressed: ()  {
                    AuthHelper().authGoogle();
                  },
                  child: const Text("Google Login"),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  child: const Text("Already Exit An Account",
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
