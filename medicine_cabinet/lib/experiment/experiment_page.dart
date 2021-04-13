import 'package:flutter/material.dart';

class ExperimentPage extends StatelessWidget {
  const ExperimentPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Experiment'),
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