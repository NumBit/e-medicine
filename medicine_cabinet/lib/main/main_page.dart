import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/error/loading_page.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'package:medicine_cabinet/main/tab_navigation.dart';
import 'package:medicine_cabinet/profile/login_page.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserState());
    final UserState userState = Get.find<UserState>();
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, user) {
          return FutureBuilder<UserModel?>(
              future: UserRepository().getMyUserModel(),
              builder: (context, userModel) {
                if (FirebaseAuth.instance.currentUser == null ||
                    !FirebaseAuth.instance.currentUser!.emailVerified) {
                  return const LoginPage();
                } else if (userModel.data == null) {
                  // TODO timeout back to login page after certain time (30s)
                  return const LoadingPage();
                } else {
                  print("FROM MAIN PAGE ----- userModel.data!.id");
                  print(userModel.data!.id);
                  userState.fromModel(userModel.data!);
                  return TabNavigation();
                }
              });
        });
  }
}
