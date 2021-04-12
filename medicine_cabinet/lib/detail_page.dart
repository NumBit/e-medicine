import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  const DetailPage({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Icon(
        Icons.medical_services_outlined,
        color: Color(0xff12263a),
        size: 50,
      )),
    );
  }
}
//test
