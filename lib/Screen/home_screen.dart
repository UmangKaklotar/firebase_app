import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Helper/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireBase APP"),
        actions: [
          IconButton(
            splashRadius: 25,
            icon: const Icon(Icons.data_object_rounded),
            onPressed: () {
              CollectionHelper().insertData();
            },
          ),
          IconButton(
            splashRadius: 25,
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc('CA').collection('stud').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Text("Something went Wrong");
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                List data = snapshot.data!.docs;
                return ListTile(
                  title: Text("${data[index]['name']}"),
                  subtitle: Text("${data[index]['age']}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
