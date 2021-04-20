import 'package:flutter/material.dart';

import 'drug_categories.dart';

class DrugHeader extends StatelessWidget {
  const DrugHeader({
    Key key,
    @required this.chemical,
    @required this.categories,
  }) : super(key: key);

  final String chemical;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: 250,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    chemical,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                DrugCategories(categories: categories)
              ],
            ),
            Icon(
              Icons.medical_services_outlined,
              color: Color(0xff12263a),
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
