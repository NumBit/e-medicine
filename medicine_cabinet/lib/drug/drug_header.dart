import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/main/app_state.dart';

import 'drug_categories.dart';

class DrugHeader extends StatelessWidget {
  const DrugHeader({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    var drug = null; //TODO
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: 300,
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
              color: Theme.of(context).primaryColorDark,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
