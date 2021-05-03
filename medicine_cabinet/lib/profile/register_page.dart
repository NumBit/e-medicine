import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/add_edit/password_field.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/profile/login_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    final pass = TextEditingController();
    final passSecond = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Register account'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Text(
                  "Register",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomFormField(
                  label: "Email",
                  controller: email,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email cannot be empty";
                    if (!GetUtils.isEmail(value)) return 'Wrong email format';
                    return null;
                  },
                ),
                PasswordField(
                  label: "Password",
                  controller: pass,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Password cannot be empty";
                    if (value.length < 6)
                      return "Password must be at leat 6 char. long";
                    if (!value.contains(RegExp(r"[0-9]")))
                      return "Password must have at least 1 number";
                    if (value != passSecond.text)
                      return "Passwords needs to match";
                    return null;
                  },
                ),
                PasswordField(
                  label: "Repeat password",
                  controller: passSecond,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Password cannot be empty";
                    if (value.length < 6)
                      return "Password must be at leat 6 char. long";
                    if (!value.contains(RegExp(r"[0-9]")))
                      return "Password must have at least 1 number";
                    if (value != pass.text) return "Passwords needs to match";
                    return null;
                  },
                ),
                LoginButton(
                  text: "Register",
                  onPressed: () {
                    {
                      if (_formKey.currentState.validate()) {
                        _register(
                            context, email.text, pass.text, passSecond.text);
                      }
                    }
                  },
                ),
              ]),
            )));
  }

  void _register(context, String email, String pass, String passSecond) async {
    if (email.isEmpty || pass.isEmpty || passSecond.isEmpty) {
      snackBarMessage("Empty field", "Fill all fields");
      return;
    }
    if (pass != passSecond) {
      snackBarMessage("Passwords are not same", "Retype your password");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      snackBarMessage("Wrong email format", "Check email format");
      return;
    }

    try {
      var userDoc = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      print("firebase OK");
      var cabId =
          await CabinetRepository().add(CabinetModel(name: "Default cabinet"));
      print("cabinet OK");
      UserRepository().add(UserModel(
          userId: userDoc.user.uid,
          name: "Your Name",
          email: email,
          openCabinetId: cabId));
      print("userRepo OK");
      UserCabinetRepository().add(UserCabinetModel(
          cabinetId: cabId,
          userId: userDoc.user.uid,
          userEmail: userDoc.user.email,
          admin: true));
      print("userCab OK");
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        snackBarMessage(
            "The password provided is too weak", "Choose stronger password");
        return;
      } else if (e.code == "email-already-in-use") {
        snackBarMessage(
            "The account already exists for that email", "Please login");
        return;
      }
    } catch (e) {
      print("Error occured in register:");
      print(e);
      snackBarMessage("Unknown error occured", "Try again later");
      return;
    }
  }
}
