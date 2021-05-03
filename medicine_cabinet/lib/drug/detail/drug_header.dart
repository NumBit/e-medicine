import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';

class DrugHeader extends StatelessWidget {
  final List<String> categories;
  final DrugModel model;
  const DrugHeader({
    Key key,
    @required this.categories,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drug = model;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
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
                  drug.substance,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              // DrugCategories(categories: categories)
            ],
          ),
          if (drug.icon.isNotEmpty)
            Icon(
              mapToIconData(jsonDecode(drug.icon)),
              color: Theme.of(context).primaryColorDark,
              size: 100,
            ),
        ],
      ),
    );
  }
}
