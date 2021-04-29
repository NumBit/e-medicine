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
        if (FirebaseAuth.instance.currentUser == null) {
          print('User is currently signed out!');
          return LoginPage();
        } else {
          print('User is signed in!');
          return FutureBuilder<UserModel>(
              future: UserRepository(context).getMyUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorPage();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  UserState userState = Get.put(UserState());
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
