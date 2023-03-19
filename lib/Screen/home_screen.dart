import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Helper/collection_helper.dart';
import 'package:firebase_app/Utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: MyColor.white,
        elevation: 0,
        title: const Text("Notes", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(child: Text("Something went Wrong"),);
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Global.notes = snapshot.data!.docs;
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListTile(
                      title: Text("${Global.notes[index]['title']}"),
                      subtitle: Text("${Global.notes[index]['des']}"),
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.delete, color: MyColor.red,),
                        onPressed: () => CollectionHelper.instance.deleteNotes(index),
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
        backgroundColor: const Color(0xffE95343),
        child: const Icon(Icons.note_add_rounded),
        onPressed: (){},
      ),
      backgroundColor: MyColor.white,
    );
  }
}
