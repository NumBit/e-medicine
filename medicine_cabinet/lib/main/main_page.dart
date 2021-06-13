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
          return StreamBuilder<UserModel?>(
              stream: UserRepository().getMyUser(),
              builder: (context, userModel) {
                if (FirebaseAuth.instance.currentUser == null) {
                  return const LoginPage();
                } else if (userModel.data == null) {
                  // TODO timeout back to login page after certain time (30s)
                  return const LoadingPage();
                } else {
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user != null && user.emailVerified) {
                    userState.fromModel(userModel.data!);
                    return TabNavigation();
                  }
                  snackBarMessage("Email is not verified",
                      "Check your inbox, new email was sent");
                  FirebaseAuth.instance.signOut();
                  return const LoginPage();
                }
              });
        });
  }
}
