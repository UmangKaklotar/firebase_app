import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/color.dart';
import '../Utils/global.dart';

class NotesDetails extends StatefulWidget {
  const NotesDetails({Key? key}) : super(key: key);

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.title.clear();
    Global.des.clear();
  }

  @override
  Widget build(BuildContext context) {
    int? index = ModalRoute.of(context)!.settings.arguments as int?;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Global.title.text = Global.notes[index!]['title'];
      Global.des.text = Global.notes[index]['des'];
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: Global.title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Enter the Notes Title",
                      hintStyle: GoogleFonts.poppins(color: MyColor.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: Global.des,
                    maxLines: 15,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      hintText: "Enter the Notes Description",
                      hintStyle: GoogleFonts.poppins(color: MyColor.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.themeColor,
        child: const Icon(CupertinoIcons.arrow_right),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, 'home', (route) => false),
      ),
      backgroundColor: MyColor.white,
    );
  }
}
