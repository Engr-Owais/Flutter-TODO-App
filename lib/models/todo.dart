import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String content;
  String todoId;
  // String title;
  Timestamp dateCreated;
  bool done;

  TodoModel({
    this.content,
    this.todoId,
    // this.title,
    this.dateCreated,
    this.done,
  });

  TodoModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    // ignore: deprecated_member_use
    todoId = documentSnapshot.documentID;
    content = documentSnapshot.data()["content"];
    // title = documentSnapshot.data()["title"];
    dateCreated = documentSnapshot.data()["dateCreated"];
    done = documentSnapshot.data()["done"];
  }

  toJson() {
    return {"content": content, "done": done};
  }
}
