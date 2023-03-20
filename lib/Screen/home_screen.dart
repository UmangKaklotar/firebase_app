import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Helper/collection_helper.dart';
import 'package:firebase_app/Utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.themeColor,
        elevation: 0,
        title: const Text(
          "Author App",
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('authors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went Wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: MyColor.themeColor),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Global.authors = snapshot.data!.docs;
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColor.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onTap: () => setState(() {
                        Global.isAuthor = true;
                        Navigator.pushNamed(context, 'note', arguments: index);
                      }),
                      title: Text("${Global.authors[index]['book']}"),
                      subtitle: Text("${Global.authors[index]['name']}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: MyColor.red,
                        ),
                        onPressed: () => setState(() {
                          CollectionHelper.instance.deleteNote(index);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Author Deleted...", style: GoogleFonts.poppins(),),
                            backgroundColor: MyColor.themeColor,
                          ));
                        }),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.themeColor,
        child: const Icon(Icons.note_add_rounded),
        onPressed: () => setState(() {
          Global.isAuthor = false;
          Navigator.pushNamed(context, 'note');
        }),
      ),
      backgroundColor: MyColor.white,
    );
  }
}
