import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/add_edit/password_field.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/profile/login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    final pass = TextEditingController();
    Future<bool> shouldPop;

    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Login account'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark),
                    child: Text('Register'),
                    onPressed: () => [
                          Navigator.pushNamed(context, "/register"),
                        ]),
              ],
            ),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Text(
                    "Login",
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
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) return 'Wrong email format';
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
                      return null;
                    },
                  ),
                  LoginButton(
                    text: "Login",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        shouldPop = _login(context, email.text, pass.text);
                      }
                    },
                  ),
                ]),
              ))),
    );
  }

  Future<bool> _login(context, String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      snackBarMessage(context, "Empty field!");
      return true;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        snackBarMessage(context, "Account not found.");
        return false;
      } else if (e.code == "wrong-password") {
        snackBarMessage(context, "Wrong password.");
        return false;
      }
    } catch (e) {
      print("Error occured in login:");
      print(e);
      snackBarMessage(context, "Unknown error occured.");
      return false;
    }
    return true;
  }
}
