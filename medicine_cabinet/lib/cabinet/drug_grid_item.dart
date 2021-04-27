import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/drug/drug_detail_page.dart';
import 'package:medicine_cabinet/drug/drug_model.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:provider/provider.dart';

class DrugGridItem extends StatelessWidget {
  final List<String> categories = ["Fever"];
  final int count = 3;

  @override
  Widget build(BuildContext context) {
    var drug = Provider.of<DrugModel>(context);
    return OpenContainer(
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        closedElevation: 5,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: Duration(milliseconds: 500),
        closedBuilder: (context, action) {
          return Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Icon(
                      mapToIconData(jsonDecode(drug.icon)),
                      color: Theme.of(context).primaryColorDark,
                      size: 50,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      drug.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
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
          );
        },
        openBuilder: (context, action) {
          Provider.of<AppState>(context, listen: false).selectedDrug = drug;
          return DrugDetailPage();
        });
  }
}

Widget getCounterText(int count) {
  return Text(count == 0 ? "Empty" : count.toString() + " ks",
      textScaleFactor: 1.2,
      style: TextStyle(
        color: Color(count <= 3 ? 0xffc33149 : 0xff12263a),
      ));
}
