import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff06BCC1),
              title: const Text('Something went wrong'),
            ),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("No connection from Firebase"),
              ),
            )));
  }
}
