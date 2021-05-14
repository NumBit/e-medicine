import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff06BCC1),
              title: Text("Loading"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: SpinKitFadingCircle(
                    color: Color(0xff12263A),
                  ),
                ),
              ),
            )));
  }
}
