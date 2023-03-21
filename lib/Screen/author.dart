import 'package:firebase_app/Model/author_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helper/collection_helper.dart';
import '../Utils/color.dart';
import '../Utils/global.dart';

class AuthorDetails extends StatefulWidget {
  const AuthorDetails({Key? key}) : super(key: key);

  @override
  State<AuthorDetails> createState() => _AuthorDetailsState();
}

class _AuthorDetailsState extends State<AuthorDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.name.clear();
    Global.book.clear();
  }

  @override
  Widget build(BuildContext context) {
    int? index = ModalRoute.of(context)?.settings.arguments as int?;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(Global.isAuthor == true) {
        Global.name.text = Global.authors[index!]['name'];
        Global.book.text = Global.authors[index]['book'];
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: Global.authorKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Book Name",
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
                      validator: (val){
                        if(val!.isEmpty) {
                          return "Please Enter Notes Book Name";
                        }
                      },
                      controller: Global.book,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        hintText: "Enter the Book Name",
                        hintStyle: GoogleFonts.poppins(color: MyColor.grey),
                        errorStyle: GoogleFonts.poppins(height: 3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Author Name",
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
                      validator: (val){
                        if(val!.isEmpty) {
                          return "Please Enter Author Name";
                        }
                      },
                      controller: Global.name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15,),
                        hintText: "Enter the Author Name",
                        hintStyle: GoogleFonts.poppins(color: MyColor.grey),
                        errorStyle: GoogleFonts.poppins(height: 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.themeColor,
        child: const Icon(CupertinoIcons.arrow_right),
        onPressed: () => setState(() {
          if(Global.authorKey.currentState!.validate()) {
            Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
            Author author = Author(name: Global.name.text, book: Global.book.text);
            if(Global.isAuthor == true) {
              CollectionHelper.instance.updateNote(index!, author);
            } else {
              CollectionHelper.instance.insertNote(author);
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Author Successfully Added...", style: GoogleFonts.poppins(),),
              backgroundColor: MyColor.themeColor,
            ));
          }
        }),
      ),
      backgroundColor: MyColor.white,
    );
  }
}
