import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/detail/add_package.dart';
import 'package:medicine_cabinet/drug/detail/description.dart';
import 'package:medicine_cabinet/drug/detail/detail_app_bar.dart';
import 'package:medicine_cabinet/drug/detail/packages_list.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'drug_header.dart';

class DrugDetailPage extends StatelessWidget {
  final String? id;
  final List<String> categories;
  final List<String> dosages;
  const DrugDetailPage({
    Key? key,
    this.categories = const ["Fever", "Pain", "Pain", "Pain", "Pain"],
    this.dosages = const ["50mg", "100mg"],
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState userState = Get.find();
    return StreamBuilder<DrugModel>(
        stream: DrugRepository(userState.openCabinetId.value).streamModel(id),
        initialData: DrugModel(
            id: "", description: "", icon: "", substance: "", name: ""),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(child: Container(child: Text("Please go back")));
          var drug = snapshot.data!;
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: CustomScrollView(
              slivers: [
                DetailAppBar(
                  model: drug,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  DrugHeader(model: drug),
                  Description(description: drug.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColorDark),
                            onPressed: () {
                              Get.dialog(AddPackage(drugId: drug.id));
                            },
                            child: Text("Add Package")),
                      ),
                    ],
                  ),
                ])),
                PackagesList(model: drug),
              ],
            ),
          );
        });
  }
}
