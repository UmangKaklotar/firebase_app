import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/author_model.dart';

class CollectionHelper {
  static CollectionHelper instance = CollectionHelper();

  CollectionReference authors = FirebaseFirestore.instance.collection('authors');

  insertNote(Author author) {
    return authors
        .add(author.toMap())
        .then((e) => print("Notes Added..."))
        .catchError((error) => print("Error : $error"));
  }

  updateNote(int index, Author author) async {
    var docSnap = await authors.get();
    var doc_id = docSnap.docs;
    return authors
        .doc(doc_id[index].id)
        .update(author.toMap())
        .then((value) => print("Notes Updated..."))
        .catchError((error) => print("Error : $error"));
  }

  deleteNote(int index) async {
    var docSnap = await authors.get();
    var doc_id = docSnap.docs;
    return authors
        .doc(doc_id[index].id)
        .delete()
        .then((e) => print("Notes Deleted..."))
        .catchError((error) => print("Error : $error"));
  }
}
