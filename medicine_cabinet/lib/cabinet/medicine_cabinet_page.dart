import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/cabinet/drug_grid_item.dart';
import 'package:medicine_cabinet/cabinet/search_bar.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/main/cabinet_id.dart';
import 'package:medicine_cabinet/main/menu.dart';

import 'chip_filter.dart';

class MedicineCabinetPage extends StatelessWidget {
  const MedicineCabinetPage();

  @override
  Widget build(BuildContext context) {
    CabinetId cabId = Get.find();
    return Obx(() => StreamBuilder<CabinetModel>(
          stream: CabinetRepository(context).streamModel(cabId.id.value),
          initialData: CabinetModel(id: "", name: ""),
          builder: (context, snapshot) => Scaffold(
            drawer: Menu(),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                snapshot.data.name,
                textScaleFactor: 1.23,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.zero,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor,
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset(0, -2),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        SearchBar(),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: SizedBox(
                            height: 60,
                            child: StreamBuilder<Object>(
                                stream: null,
                                builder: (context, snapshot) {
                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ChipFilter(name: "Filter"),
                                      ChipFilter(name: "Filter"),
                                      ChipFilter(name: "Filter"),
                                      ChipFilter(name: "Filter"),
                                      ChipFilter(name: "Filter"),
                                      ChipFilter(name: "Filter"),
                                    ],
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                StreamBuilder<List<DrugModel>>(
                    stream:
                        DrugRepository(context, cabId.id.value).streamModels(),
                    initialData: [],
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      return SliverPadding(
                          padding: EdgeInsets.all(15),
                          sliver: SliverGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            children: snapshot.data
                                .map((m) => DrugGridItem(model: m))
                                .toList(),
                          ));
                    }),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, "/add_drug");
              },
              backgroundColor: Theme.of(context).primaryColor,
              tooltip: 'Add medication',
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              label: Text(
                "Add",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }
}
