import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/user_model.dart';
import 'package:medicine_cabinet/firebase/user_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage();

  @override
  Widget build(BuildContext context) {
    //final user = context.read<UserCubit>();
    final email = TextEditingController();
    final pass = TextEditingController();
    final passSecond = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Register account'),
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
              Text("Repeat password:"),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passSecond,
              ),
              ElevatedButton(
                  child: Text('Register'),
                  onPressed: () => [
                        _register(
                            context, email.text, pass.text, passSecond.text),
                        Navigator.pop(context)
                      ])
            ])));
  }

  void _register(context, String email, String pass, String passSecond) async {
    if (email.isEmpty || pass.isEmpty || passSecond.isEmpty) {
      snackBarMessage(context, "Empty field!");
      return;
    }
    if (pass != passSecond) {
      snackBarMessage(context, "Passwords are not same!");
      return;
    }
    try {
      var doc = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      UserRepository(context).add(UserModel(
          id: doc.user.uid,
          name: "Your Name",
          email: email,
          defaultCabinet: ""));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        snackBarMessage(context, "The password provided is too weak.");
        return;
      } else if (e.code == "email-already-in-use") {
        snackBarMessage(context, "The account already exists for that email.");
        return;
      }
    } catch (e) {
      print(e);
      snackBarMessage(context, "Unknown error occured.");
      return;
    }
  }
}
