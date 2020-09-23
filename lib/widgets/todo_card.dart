import 'package:firestore_flutter/models/todo.dart';
import 'package:firestore_flutter/services/database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class TodoCard extends StatefulWidget {
  final String uid;
  final TodoModel todo;

  TodoCard({Key key, this.uid, this.todo}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                  title: Text(widget.todo.content,
                      style: (widget.todo.done)
                          ? TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough)
                          : TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color)),
                  trailing: Icon(Icons.update),
                  onTap: () => alertDialog(context),
                  onLongPress: () => {
                        Database().deleteOne(widget.uid, widget.todo.todoId),
                        Get.snackbar(
                            "TASK DELETED", "Your Task Successfully Deleted !")
                      }),
            ),
            Checkbox(
              value: widget.todo.done,
              onChanged: (newValue) {
                Database().updateTodo(newValue, widget.uid, widget.todo.todoId);
              },
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController contentupd = new TextEditingController();

  void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Update Task"),
      content: TextFormField(
        controller: contentupd,
      ),
      actions: [
        FlatButton(
          child: Text('Update'),
          onPressed: () {
            if (contentupd.text != "") {
              Database()
                  .updateOne(contentupd.text, widget.uid, widget.todo.todoId);
              Navigator.of(context).pop();
            } else {
              Get.snackbar("Error", "NO UPDATE");
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
