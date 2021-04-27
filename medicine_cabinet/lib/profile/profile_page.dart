import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final int cabinets;
  final int drugs;
  final int pills;

  const ProfilePage({
    Key key,
    this.cabinets = 3,
    this.drugs = 21,
    this.pills = 190,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "My profile",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w400,
              fontSize: 30),
        ),
      ),
      body: Container(
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    FirebaseAuth.instance.currentUser.email,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _getColumn(context, "Cabinets", cabinets),
                      _getColumn(context, "Drugs", drugs),
                      _getColumn(context, "Pills", pills),
                    ],
                  ),
                ),
                ElevatedButton(
                    child: Text('Logout'),
                    onPressed: () => [
                          FirebaseAuth.instance.signOut(),
                          Navigator.pop(context)
                        ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getColumn(context, String text, int number) {
  return Column(
    children: [
      Text(
        text,
        textScaleFactor: 1.2,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(number.toString()),
      ),
    ],
  );
}
