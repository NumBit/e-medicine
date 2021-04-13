import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm();

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
                      ])
            ])));
  }
}

void _register(context, String email, String pass, String passSecond) async {
  if (email.isEmpty || pass.isEmpty || passSecond.isEmpty) {
    _displaySnackBarMessage(context, "Empty field!");
    return;
  }
  if (pass != passSecond) {
    _displaySnackBarMessage(context, "Passwords are not same!");
    return;
  }
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      _displaySnackBarMessage(context, "The password provided is too weak.");
      return;
    } else if (e.code == "email-already-in-use") {
      _displaySnackBarMessage(
          context, "The account already exists for that email.");
      return;
    }
  } catch (e) {
    print(e);
    _displaySnackBarMessage(context, "Unknown error occured.");
    return;
  }
  _displaySnackBarMessage(context, "Account created.");
}

void _displaySnackBarMessage(context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
