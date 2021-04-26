import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'dart:async';
import 'error/error_page.dart';
import 'error/loading_page.dart';
import 'main/medicine_cabinet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MedicineCabinetApp());
}

class MedicineCabinetApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorPage();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print('neni loading');
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot == null) {
                  print('User is currently signed out!');
                  return LoginPage();
                } else {
                  print('User is signed in!');
                  return MedicineCabinet();
                }
              });

          /*FirebaseAuth.instance.authStateChanges().listen((User user) {
            if (user == null) {
              print('User is currently signed out!');
              return Navigator.pushNamed(context, "/login");
            } else {
              print('User is signed in!');

              //return Navigator.pushNamed(context, "/");
            }
          });*/
        }
        return LoadingPage();
      },
    );
  }
}
