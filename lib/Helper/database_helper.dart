import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Model/user_model.dart';

class CollectionHelper {
  insertData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc('CA').collection('stud');
    return users
        .add({'name': "Sahil", 'age': 20})
        .then((value) => print("User Added.."))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
