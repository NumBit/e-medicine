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

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    final pass = TextEditingController();
    final passSecond = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Medicine cabinet"),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Form(
              key: formKey,
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
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!GetUtils.isEmail(value)) return 'Wrong email format';
                    return null;
                  },
                ),
                PasswordField(
                  label: "Password",
                  controller: pass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at leat 6 char. long";
                    }
                    // ignore: unnecessary_raw_strings
                    if (!value.contains(RegExp(r"[0-9]"))) {
                      return "Password must have at least 1 number";
                    }
                    if (value != passSecond.text) {
                      return "Passwords needs to match";
                    }
                    return null;
                  },
                ),
                PasswordField(
                  label: "Repeat password",
                  controller: passSecond,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at leat 6 char. long";
                    }
                    // ignore: unnecessary_raw_strings
                    if (!value.contains(RegExp(r"[0-9]"))) {
                      return "Password must have at least 1 number";
                    }
                    if (value != pass.text) return "Passwords needs to match";
                    return null;
                  },
                ),
                LoginButton(
                  "Register",
                  onPressed: () {
                    {
                      if (formKey.currentState!.validate()) {
                        _register(
                            context, email.text, pass.text, passSecond.text);
                      }
                    }
                  },
                ),
              ]),
            )));
  }

  Future<void> _register(BuildContext context, String email, String pass,
      String passSecond) async {
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
      final userDoc = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      final cabId = await CabinetRepository()
          .add(const CabinetModel(name: "Default cabinet"));
      UserRepository().add(UserModel(
          userId: userDoc.user!.uid,
          name: "Your Name",
          email: email,
          openCabinetId: cabId));
      UserCabinetRepository().add(UserCabinetModel(
          cabinetId: cabId,
          userId: userDoc.user!.uid,
          userEmail: userDoc.user!.email,
          admin: true));

      // EMAIL VERIFICATION
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        snackBarMessage(
            "Email verification was sent", "Please verify your email",
            timeout: 10);
      }
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
      debugPrint("Error occured in register:");
      debugPrint(e.toString());
      snackBarMessage("Unknown error occured", "Try again later");
      return;
    }
    Get.offAll(const LoginPage());
    FirebaseAuth.instance.signOut();
    snackBarMessage("Email verification was sent", "Please verify your email",
        timeout: 10);
  }
}
