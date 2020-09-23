import 'package:firestore_flutter/controllers/authController.dart';
import 'package:firestore_flutter/controllers/userController.dart';
import 'package:firestore_flutter/screens/home.dart';
import 'package:firestore_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
