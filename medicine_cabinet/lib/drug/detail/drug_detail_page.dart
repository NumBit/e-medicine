import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/detail/add_package.dart';
import 'package:medicine_cabinet/drug/detail/description.dart';
import 'package:medicine_cabinet/drug/detail/detail_app_bar.dart';
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
        builder: (context, model) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: CustomScrollView(
              slivers: [
                DetailAppBar(
                  model: model.data,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  DrugHeader(categories: categories, model: model.data),
                  Description(description: model.data.description),
                  // Divider(
                  //   color: Theme.of(context).primaryColorDark,
                  //   height: 20,
                  //   thickness: 5,
                  //   indent: 20,
                  //   endIndent: 20,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColorDark),
                            onPressed: () {
                              Get.dialog(AddPackage());
                            },
                            child: Text("Add Package")),
                      ),
                    ],
                  ),
                ])),
                PackagesList(model: model.data),
              ],
            ),
          );
        });
  }
}
