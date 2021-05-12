import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'package:medicine_cabinet/profile/edit_profile.dart';
import 'package:medicine_cabinet/profile/login_button.dart';

class ProfilePage extends StatelessWidget {
  final int drugs;
  final int pills;

  const ProfilePage({
    Key key,
    this.drugs = 21,
    this.pills = 190,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState userModel = Get.find();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(500),
              border: Border.all(color: Color(0x66EDB88B)),
              boxShadow: [
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
              child: Image.network(
                "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
              ),
            ),
            //  asset("assets/avatar.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                StreamBuilder<UserModel>(
                    stream: UserRepository().getMyUser(),
                    initialData: UserModel(name: ""),
                    builder: (context, user) {
                      return Text(
                        user.data.name,
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      );
                    }),
                Text(
                  FirebaseAuth.instance.currentUser.email,
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
                _getColumn(context, "Drugs", drugs),
                _getColumn(context, "Pills", pills),
              ],
            ),
          ),
          LoginButton(
            text: "Logout",
            onPressed: () {
              _signOut();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  void _signOut() {
    // ignore: unused_local_variable
    UserState user = Get.find();
    // ignore: unused_local_variable
    NavigationState nav = Get.find();
    user = UserState();
    nav.navigatorId.value = 0;
    FirebaseAuth.instance.signOut();
  }
}

Widget _getColumn(context, String text, int number) {
  return Material(
    elevation: 5,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      width: 110,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                text,
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              number.toString(),
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
