import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/drug_detail_page.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'package:medicine_cabinet/profile/profile_page.dart';
import 'cabinet/medicine_cabinet_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine cabinet',
      theme: ThemeData(
          primaryColor: Color(0xff06BCC1),
          primaryColorDark: Color(0xff12263A),
          primarySwatch: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white)),
      initialRoute: "/",
      routes: {
        "/": (context) => MedicineCabinetPage(),
        "/login": (context) => LoginPage(),
        "/profile": (context) => ProfilePage(),
        "/drug": (context) => DrugDetailPage(),
      },
    );
  }
}
