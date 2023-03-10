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

  updateData({required int index, required UserData userData}) async {
    var docSnap = await users.get();
    var doc_id = docSnap.docs;
    return users
        .doc(doc_id[index].id)
        .update(userData.toMap())
        .then((value) => print("User Updated.."))
        .catchError((error) => print("Failed to update user: $error"));
  }

  deleteData({required int index}) async {
    var docSnap = await users.get();
    var doc_id = docSnap.docs;
    return users
        .doc(doc_id[index].id)
        .delete()
        .then((value) => print("User Deleted.."))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
