import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/cabinet_page.dart';
import 'package:medicine_cabinet/error/error_page.dart';
import 'package:medicine_cabinet/error/loading_page.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, s) {
        Get.put(UserState());
        if (FirebaseAuth.instance.currentUser == null) {
          print('User is currently signed out!');
          return LoginPage();
        } else {
          print('User is signed in!');
          UserState userState = Get.find<UserState>();
          if (userState.id.value.isNotEmpty) {
            print("THIS: " + userState.id.value);
            print("got info from GETxxxxxxxxxxxx");
            return CabinetPage();
          }
          return FutureBuilder<UserModel>(
              future: UserRepository(context).getMyUser(),
              builder: (context, snapshot) {
                print("123THIS: " + userState.id.value);
                if (snapshot.hasError) {
                  return ErrorPage();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  //TODO extra null check in future
                  print("FFF got info from FIREBASE");
                  userState.id.value = snapshot.data.id;
                  userState.email.value = snapshot.data.email;
                  userState.name.value = snapshot.data.name;
                  userState.userId.value = snapshot.data.userId;
                  userState.openCabinetId.value = snapshot.data.openCabinetId;
                  return CabinetPage();
                }
                return LoadingPage();
              });
        }
      },
    );
  }
}
