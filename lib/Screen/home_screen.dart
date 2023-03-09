import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Helper/collection_helper.dart';
import 'package:firebase_app/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireBase APP"),
        actions: [
          IconButton(
            splashRadius: 25,
            icon: const Icon(Icons.update),
            onPressed: () {
              CollectionHelper.instance.updateData();
            },
          ),
          IconButton(
            splashRadius: 25,
            icon: const Icon(Icons.delete),
            onPressed: () {
              CollectionHelper.instance.deleteData();
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
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter The Name",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: age,
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
              var userData = UserData(name: name.text, age: int.parse(age.text));
              CollectionHelper.instance.insertData(userData);
              name.clear();
              age.clear();
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
          ),
        ],
      ),
    );
  }
}
