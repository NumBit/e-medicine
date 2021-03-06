import 'package:flutter/material.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff06BCC1),
              title: const Text("Loading"),
            ),
            body: const LoadingWidget()));
  }
}
