import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Model/user_model.dart';

class CollectionHelper {
  static CollectionHelper instance = CollectionHelper();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  insertData(UserData userData) async {
    return users
        .add(userData.toMap())
        .then((value) => print("User Added.."))
        .catchError((error) => print("Failed to add user: $error"));
  }

  updateData() {
    return users
        .doc('r6Ax5LypEKFkq4Mtes0U')
        .update(UserData(name: "Shreya", age: 21).toMap())
        .then((value) => print("User Updated.."))
        .catchError((error) => print("Failed to update user: $error"));
  }

  deleteData() {
    return users
        .doc('E8usoulZ54uTc2jbw1sw')
        .delete()
        .then((value) => print("User Deleted.."))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
