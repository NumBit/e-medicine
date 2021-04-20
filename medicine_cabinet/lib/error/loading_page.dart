import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Please wait'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("Loading..."),
                ),
              ),
            )));
  }
}
