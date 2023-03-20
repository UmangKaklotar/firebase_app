import 'package:flutter/material.dart';

class Global {
  static List notes = [];
  static bool isNotes = false;
  static final notesKey = GlobalKey<FormState>();
  static TextEditingController title = TextEditingController(),
      des = TextEditingController();
}
