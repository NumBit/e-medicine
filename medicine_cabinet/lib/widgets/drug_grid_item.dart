import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../detail_page.dart';

class DrugGridItem extends StatelessWidget {
  final String name = "Paralen ultra deluxe";
  final Icon icon = Icon(Icons.medical_services_outlined);
  final List<String> categories = ["Fever"];
  final int count = 3;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Center(
                  child: Hero(
                    tag: "icon",
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: Color(0xff12263a),
                      size: 50,
                    ),
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
                      Container(child: getCounterText(count))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DetailPage(
                            name: name,
                          ))),
            ),
          )
        ],
      ),
    );
  }
}

Widget getCounterText(int count) {
  return Text(count == 0 ? "Empty" : count.toString() + " ks",
      textScaleFactor: 1.2,
      style: TextStyle(
        color: Color(count <= 3 ? 0xffc33149 : 0xff12263a),
      ));
}
