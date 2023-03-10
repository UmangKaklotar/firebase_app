import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Helper/collection_helper.dart';
import 'package:firebase_app/Model/user_model.dart';
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
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
      //   builder: (context, snapshot) {
      //     if(snapshot.hasError) {
      //       return const Text("Something went Wrong");
      //     } else if(snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator(),);
      //     } else {
      //       return ListView.builder(
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (context, index) {
      //           List data = snapshot.data!.docs;
      //           return ListTile(
      //             title: Text("${data[index]['name']}"),
      //             subtitle: Text("${data[index]['age']}"),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: Global.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter The Name",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: Global.age,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter The Age",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton.filled(
            child: const Text("Insert Data"),
            onPressed: (){
              var userData = UserData(name: Global.name.text, age: int.parse(Global.age.text));
              CollectionHelper.instance.insertData(userData);
              Global.name.clear();
              Global.age.clear();
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return const Text("Something went Wrong!");
                } else if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Global.userData = snapshot.data!.docs;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        onTap: () => Navigator.pushNamed(context, 'edit', arguments: index),
                        title: Text("${Global.userData[index]['name']}"),
                        subtitle: Text("${Global.userData[index]['age']}"),
                        trailing: IconButton(
                          splashRadius: 25,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            CollectionHelper.instance.deleteData(index: index);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
