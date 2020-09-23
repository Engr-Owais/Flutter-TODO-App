import 'package:firestore_flutter/controllers/authController.dart';
import 'package:firestore_flutter/controllers/todoController.dart';
import 'package:firestore_flutter/controllers/userController.dart';
import 'package:firestore_flutter/services/database.dart';
import 'package:firestore_flutter/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController _todoController = TextEditingController();
  // final TextEditingController _todotitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
                await Database().getUser(Get.find<AuthController>().user.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text("Welcome " + _.user.name);
            } else {
              return Text("GUEST"+controller.user.uid.toString());
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Enter Your Task",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: new InputDecoration(hintText: "Enter Task Full Description"),
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "" ) {
                        Database().addTodo(_todoController.text,
                            controller.user.uid);
                        Get.snackbar('SUCCES', 'Task Added',
                            backgroundColor: Colors.blue,
                            icon: Icon(Icons.check),
                            duration: (Duration(seconds: 2)));
                        _todoController.clear();
                      } else {
                        Get.snackbar('ALERT !', 'Enter Your task',
                            barBlur: 20,
                            icon: Icon(Icons.add_alert),
                            backgroundColor: Colors.red,
                            duration: (Duration(seconds: 2)));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<TodoController>(
            init: Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController != null && todoController.todos != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoController.todos.length,
                    itemBuilder: (_, index) {
                      return TodoCard(
                          uid: controller.user.uid,
                          todo: todoController.todos[index]);
                    },
                  ),
                );
              } else {
                return Text("loading...");
              }
            },
          )
        ],
      ),
    );
  }
}
