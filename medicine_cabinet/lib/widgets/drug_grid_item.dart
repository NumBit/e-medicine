import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrugGridItem extends StatelessWidget {
  final String name = "Paralen ultra deluxe";
  final Icon icon = Icon(Icons.medical_services_outlined);
  final List<String> categories = ["Fever"];
  final int count = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300], width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(3, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Center(
            child: Icon(
              Icons.medical_services_outlined,
              color: Color(0xff12263a),
              size: 50,
            ),
          )),
          Container(
              child: Text(
            name,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff12263a),
              fontWeight: FontWeight.w400,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    categories.first,
                    textScaleFactor: 1.2,
                  ),
                ),
                Container(
                  child: Text(
                    count.toString() + " ks",
                    textScaleFactor: 1.2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
