import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          // ListTile(
          //   title: Text("Profile"),
          //   onTap: () => Get.toNamed("/profile"),
          // ),
          // ListTile(
          //   title: Text("Schedule"),
          //   onTap: () => Get.toNamed("/schedule"),
          // ),
          // ListTile(
          //   title: Text("Cabinets"),
          //   onTap: () => Get.toNamed("/cabinets_list"),
          // ),
          ListTile(
            title: Text("Experiment"),
            onTap: () => Get.toNamed("/experiment"),
          ),
          // ListTile(
          //   title: Text("Tabbars"),
          //   onTap: () => Get.to(() => TabNavigation()),
          // )
        ],
      ),
    );
  }
}
