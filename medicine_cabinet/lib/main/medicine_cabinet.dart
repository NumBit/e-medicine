import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/medicine_cabinet_page.dart';
import 'package:medicine_cabinet/drug/drug_detail_page.dart';
import 'package:medicine_cabinet/experiment/experiment_page.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'package:medicine_cabinet/profile/profile_page.dart';
import 'package:medicine_cabinet/schedule/schedule_page.dart';

class MedicineCabinet extends StatelessWidget {
  const MedicineCabinet({
    Key key,
  }) : super(key: key);

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
        "/schedule": (context) => SchedulePage(),
        "/experiment": (context) => ExperimentPage(),
      },
    );
  }
}
