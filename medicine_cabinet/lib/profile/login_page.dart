import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    Future<bool> shouldPop;

    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Login account'),
          ),
          body: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Text("Email:"),
                TextField(
                  controller: email,
                ),
                Text("Password:"),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: pass,
                ),
                ElevatedButton(
                    child: Text('Login'),
                    onPressed: () => [
                          shouldPop = _login(context, email.text, pass.text),
                        ]),
                ElevatedButton(
                    child: Text('Register'),
                    onPressed: () => [
                          Navigator.pushNamed(context, "/register"),
                        ]),
              ]))),
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
      var state = Provider.of<AppState>(context, listen: false);
      //state.cabinet = cabId;
      // TODO
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        snackBarMessage(context, "Account not found.");
        return false;
      } else if (e.code == "wrong-password") {
        snackBarMessage(context, "Wrong password.");
        return false;
      }
    } catch (e) {
      print(e);
      snackBarMessage(context, "Unknown error occured.");
      return false;
    }
    return true;
  }
}
