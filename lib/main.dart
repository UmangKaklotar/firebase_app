import 'package:firebase_app/Screen/auth_state.dart';
import 'package:firebase_app/Screen/edit_profile.dart';
import 'package:firebase_app/Screen/home_screen.dart';
import 'package:firebase_app/Screen/sign_in.dart';
import 'package:firebase_app/Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screen/sign_up.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "My Channel", "Notification Channel",
    description: "This Channel is used for impotant Notification",
    importance: Importance.max);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(color: Colors.black),
          bodyText1: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'state': (context) => const AuthState(),
        'signIn': (context) => const SignIn(),
        'signUp': (context) => const SignUp(),
        'home': (context) => const HomeScreen(),
        'edit': (context) => const EditProfile(),
      },
    ),
  );
}