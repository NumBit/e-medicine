import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'error/error_page.dart';
import 'error/loading_page.dart';
import 'medicine_cabinet.dart';

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
          return MedicineCabinet();
        }
        return LoadingPage();
      },
    );
  }
}
