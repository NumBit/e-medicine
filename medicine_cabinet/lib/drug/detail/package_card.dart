import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "50mg",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Exp. 12/2021"),
            Text(
              "40 ks",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  Icons.add,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              Text(
                "40 Ks",
                textScaleFactor: 1.8,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
