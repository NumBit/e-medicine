import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/firebase/storage/storage.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'package:medicine_cabinet/profile/edit_profile.dart';
import 'package:medicine_cabinet/profile/login_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    // var picture = Get.put(ProfilePicture());
    final UserState userModel = Get.find();
    CabinetRepository().drugCount();
    CabinetRepository().pillCount();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                Get.dialog(EditProfile(name: userModel.name.value));
              },
            ),
          ],
          title: Text(
            "Profile",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w400,
                fontSize: 30),
          ),
        ),
        body: StreamBuilder<UserModel?>(
            stream: UserRepository().getMyUser(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const LoadingWidget();
              final user = snapshot.data!;
              final path = user.profilePicture;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(500),
                      border: Border.all(color: const Color(0x66EDB88B)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffEDB88B),
                          offset: Offset(2, 4),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: (path == null ||
                              path == "" ||
                              !File(path).existsSync())
                          ? Image.asset(
                              "assets/avatar.png",
                              fit: BoxFit.cover,
                            )
                          : FutureBuilder<String>(
                              future: Storage().getLink(path),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const LoadingWidget();
                                }
                                return Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                    ),
                    //  asset("assets/avatar.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Text(
                          user.name!,
                          textScaleFactor: 1.5,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser?.email ??
                              "No email",
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<int>(
                            stream: CabinetRepository().cabinetCount(),
                            initialData: 0,
                            builder: (context, cabinetsCount) {
                              return _getColumn(
                                  context, "Cabinets", cabinetsCount.data);
                            }),
                        Obx(() => _getColumn(
                            context, "Drugs", userModel.drugsCount.value)),
                        Obx(() => _getColumn(
                            context, "Pills", userModel.pillCount.value)),
                      ],
                    ),
                  ),
                  LoginButton(
                    "Logout",
                    onPressed: () {
                      _signOut();
                      Get.back();
                    },
                  )
                ],
              );
            }));
  }

  void _signOut() {
    // ignore: unused_local_variable
    UserState user = Get.find();
    // ignore: unused_local_variable
    final NavigationState nav = Get.find();
    user = UserState();
    nav.navigatorId.value = 0;
    FirebaseAuth.instance.signOut();
  }
}

Widget _getColumn(BuildContext context, String text, int? number) {
  return Material(
    elevation: 5,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: SizedBox(
      width: 110,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                text,
                textScaleFactor: 1.2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              number?.toString() ?? "0",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
