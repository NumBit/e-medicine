import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final FirebaseAuth auth;

  const RegisterForm(this.auth);

  @override
  Widget build(BuildContext context) {
    //final user = context.read<UserCubit>();
    final email = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Register account'),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Text("Name:"),
              TextField(
                controller: email,
              ),
              Text("Text:"),
              TextField(
                controller: pass,
              ),
              ElevatedButton(
                  child: Text('Add'),
                  onPressed: () => [
                        Register(auth, email.text, pass.text),
                        Navigator.pop(context),
                      ])
            ])));
  }
}

Future<void> Register(auth, email, pass) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  print("ALL OK, USER CREATED");
}
