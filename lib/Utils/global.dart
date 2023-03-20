import 'package:flutter/material.dart';

class Global {
  static List authors = [];
  static bool isAuthor = false;
  static final authorKey = GlobalKey<FormState>();
  static TextEditingController name = TextEditingController(),
      book = TextEditingController();
}
