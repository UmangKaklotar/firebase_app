import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4),() => Navigator.pushReplacementNamed(context, 'state'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffEAEEEF),
        alignment: Alignment.center,
        child: Image.asset('assets/image/firebase_logo.gif',
          width: 300,
        ),
      ),
    );
  }
}
