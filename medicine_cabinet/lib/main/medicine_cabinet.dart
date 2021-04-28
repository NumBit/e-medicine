import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/cabinet/medicine_cabinet_page.dart';
import 'package:medicine_cabinet/cabinets/cabinets_list_page.dart';
import 'package:medicine_cabinet/drug/add_drug.dart';
import 'package:medicine_cabinet/drug/drug_detail_page.dart';
import 'package:medicine_cabinet/drug/edit_drug.dart';
import 'package:medicine_cabinet/experiment/experiment_page.dart';
import 'package:medicine_cabinet/main/main_page.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'package:medicine_cabinet/profile/profile_page.dart';
import 'package:medicine_cabinet/profile/register_page.dart';
import 'package:medicine_cabinet/schedule/schedule_page.dart';

class MedicineCabinet extends StatelessWidget {
  const MedicineCabinet({
    Key key,
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
        "/main": (context) => MedicineCabinetPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/profile": (context) => ProfilePage(),
        "/drug": (context) => DrugDetailPage(),
        "/schedule": (context) => SchedulePage(),
        "/experiment": (context) => ExperimentPage(),
        "/add_drug": (context) => AddDrug(),
        "/edit_drug": (context) => EditDrug(),
        "/cabinets_list": (context) => CabinetsListPage(),
        "drug_detail": (context) => DrugDetailPage(),
      },
    );
  }
}
