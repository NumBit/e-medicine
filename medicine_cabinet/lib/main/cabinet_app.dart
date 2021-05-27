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
          primaryColor: const Color(0xff06BCC1),
          primaryColorDark: const Color(0xff12263A),
          errorColor: const Color(0xffc33149),
          primarySwatch: Colors.teal,
          iconTheme: const IconThemeData(color: Colors.white)),
      initialRoute: "/",
      routes: {
        "/": (context) => const MainPage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/experiment": (context) => const ExperimentPage(),
      },
    );
  }
}
