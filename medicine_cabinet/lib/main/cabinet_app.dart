import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/experiment/experiment_page.dart';
import 'package:medicine_cabinet/main/main_page.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'package:medicine_cabinet/profile/register_page.dart';

class CabinetApp extends StatelessWidget {
  const CabinetApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine cabinet',
      theme: ThemeData(
          primaryColor: Color(0xff06BCC1),
          primaryColorDark: Color(0xff12263A),
          errorColor: Color(0xffc33149),
          primarySwatch: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white)),
      initialRoute: "/",
      routes: {
        "/": (context) => MainPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/experiment": (context) => ExperimentPage(),
      },
    );
  }
}
