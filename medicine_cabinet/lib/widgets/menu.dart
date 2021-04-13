import 'package:flutter/material.dart';
import 'package:medicine_cabinet/page/login_page.dart';
import 'package:medicine_cabinet/page/profile_page.dart';

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
          ListTile(
            title: Text("Profile"),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage())),
          ),
          ListTile(
            title: Text("Schedule"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Login"),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage())), //Login()
          )
        ],
      ),
    );
  }
}
