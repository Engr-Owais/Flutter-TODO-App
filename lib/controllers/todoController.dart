import 'package:firestore_flutter/controllers/authController.dart';
import 'package:firestore_flutter/services/database.dart';
import 'package:get/get.dart';
import 'package:firestore_flutter/models/todo.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user.uid;
    todoList
        .bindStream(Database().todoStream(uid)); //stream coming from firebase
  }
}
