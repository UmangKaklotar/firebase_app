import 'package:firebase_app/Screen/edit_profile.dart';
import 'package:firebase_app/Screen/home_screen.dart';
import 'package:firebase_app/Screen/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screen/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(color: Colors.black),
          bodyText1: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyApp(),
        'signIn': (context) => const SignIn(),
        'signUp': (context) => const SignUp(),
        'home': (context) => const HomeScreen(),
        'edit': (context) => const EditProfile(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}
