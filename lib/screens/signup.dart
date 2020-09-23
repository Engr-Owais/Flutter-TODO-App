import 'package:firestore_flutter/controllers/authController.dart';
import 'package:firestore_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  controller: nameController,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    icon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                  controller: emailController,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.security,
                      color: Colors.black,
                    ),
                  ),
                  obscureText: true,
                  controller: passwordController,
                ),
                FlatButton(
                  child: Text("Sign Up"),
                  onPressed: () {
                    controller.createUser(nameController.text,
                        emailController.text, passwordController.text);

                        
                  },
                ),
                FlatButton(
                  child: Text("Login"),
                  onPressed: () {
                    Get.off(Login());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
