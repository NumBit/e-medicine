import 'package:flutter/material.dart';

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
            onTap: () => Navigator.pushNamed(context, "/profile"),
          ),
          ListTile(
            title: Text("Schedule"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Login"),
            onTap: () => Navigator.pushNamed(context, "/login"), //Login()
          )
        ],
      ),
    );
  }
}
