import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/note_model.dart';

class CollectionHelper {
  static CollectionHelper instance = CollectionHelper();

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  insertNote(Notes note) {
    return notes
        .add(note.toMap())
        .then((e) => print("Notes Added..."))
        .catchError((error) => print("Error : $error"));
  }

  updateNote(int index, Notes note) async {
    var docSnap = await notes.get();
    var doc_id = docSnap.docs;
    return notes
        .doc(doc_id[index].id)
        .update(note.toMap())
        .then((value) => print("Notes Updated..."))
        .catchError((error) => print("Error : $error"));
  }

  deleteNote(int index) async {
    var docSnap = await notes.get();
    var doc_id = docSnap.docs;
    return notes
        .doc(doc_id[index].id)
        .delete()
        .then((e) => print("Notes Deleted..."))
        .catchError((error) => print("Error : $error"));
  }
}
