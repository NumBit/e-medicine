import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrugGridItem extends StatelessWidget {
  final String name = "Paralen ultra delddsgsdgdsgdsgdsg dgsd guxe";
  final Icon icon = Icon(Icons.medical_services_outlined);
  final List<String> categories = ["Fever"];
  final int count = 3;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () =>
            Navigator.pushNamed(context, "drug_detail", arguments: name),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Icon(
                  Icons.medical_services_outlined,
                  color: Color(0xff12263a),
                  size: 50,
                ),
              ),
              Flexible(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff12263a),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categories.first,
                      textScaleFactor: 1.2,
                    ),
                    getCounterText(count)
                  ],
                ),
              ),
            ],
          ),
        ),
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
