import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screen/home_screen.dart';
import 'Screen/splash_screen.dart';
import 'Utils/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(color: MyColor.black),
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(color: MyColor.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'home': (context) => const HomeScreen(),
      },
    ),
  );
}