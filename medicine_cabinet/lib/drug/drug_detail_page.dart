import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/drug_model.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:provider/provider.dart';

import 'description_scroll_list.dart';
import 'drug_header.dart';

class DrugDetailPage extends StatelessWidget {
  final String chemical;
  final List<String> categories;
  final List<String> dosages;
  final String description =
      "Nam ultricies metus ut dolor hendrerit, sit amet volutpat justo hendrerit. Aenean pretium, massa eget varius sagittis, mi lorem malesuada turpis, id ultricies purus erat at arcu. Proin egestas risus non ex faucibus interdum. Ut sagittis magna at ex ullamcorper, sed varius lorem condimentum. Nunc dignissim velit gravida rhoncus feugiat. Mauris ligula tortor, ornare dapibus efficitur a, fringilla nec neque. Pellentesque vel ante odio. Duis efficitur malesuada tempor. Aliquam maximus, libero bibendum tristique fermentum, quam metus maximus elit, ut fermentum magna turpis vel urna. Mauris non metus augue. Mauris lectus massa, sodales non lacus id, sollicitudin semper felis. Donec porta leo quis diam hendrerit, sed bibendum arcu scelerisque.";
  const DrugDetailPage({
    Key key,
    this.chemical = "Paracetamol",
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
