import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/detail/packages_list.dart';
import 'package:medicine_cabinet/main/cabinet_id.dart';
import 'drug_header.dart';

class DrugDetailPage extends StatelessWidget {
  final String id;
  final List<String> categories;
  final List<String> dosages;
  const DrugDetailPage({
    Key key,
    this.categories = const ["Fever", "Pain", "Pain", "Pain", "Pain"],
    this.dosages = const ["50mg", "100mg"],
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CabinetId cabId = Get.find();
    return StreamBuilder<DrugModel>(
        stream: DrugRepository(context, cabId.id.value).streamModel(id),
        initialData: DrugModel(
            id: "", description: "", icon: "", latinName: "", name: ""),
        builder: (context, drug) {
          // if (!drug.hasData) return Text("Loading");
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  DrugHeader(categories: categories, model: drug.data),
                  PackagesList(model: drug.data),
                ],
              ),
            ),
          );
        });
  }
}
