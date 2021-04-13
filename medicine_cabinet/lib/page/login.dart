import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({
    Key key,
  }) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                "Login",
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
                  height: MediaQuery.of(context).size.height * 0.55,
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
                          "text",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "email",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("abc"),
                            Text("abc"),
                            Text("abc"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
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
