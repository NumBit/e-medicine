import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:provider/provider.dart';

import 'drug_categories.dart';

class DrugHeader extends StatelessWidget {
  const DrugHeader({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    var drug = Provider.of<AppState>(context).selectedDrug;
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
                    drug.latinName,
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
              mapToIconData(jsonDecode(drug.icon)),
              color: Color(0xff12263a),
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
