import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/drug_model.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:provider/provider.dart';

import 'description_scroll_list.dart';
import 'drug_header.dart';

class DrugDetailPage extends StatelessWidget {
  final List<String> categories;
  final List<String> dosages;
  const DrugDetailPage({
    Key key,
    this.categories = const ["Fever", "Pain", "Pain", "Pain", "Pain"],
    this.dosages = const ["50mg", "100mg"],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drug = Provider.of<AppState>(context).selectedDrug;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            DrugHeader(categories: categories),
            DescriptionScrollList(
                name: drug.name, description: drug.description),
          ],
        ),
      ),
    );
  }
}
