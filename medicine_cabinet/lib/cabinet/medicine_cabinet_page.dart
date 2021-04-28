import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/cabinet_app_bar.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/cabinet/drug_grid_item.dart';
import 'package:medicine_cabinet/cabinet/search_bar.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/main/cabinet_id.dart';
import 'package:medicine_cabinet/main/filter.dart';
import 'package:medicine_cabinet/main/menu.dart';

import 'chip_filter.dart';

class MedicineCabinetPage extends StatelessWidget {
  const MedicineCabinetPage();

  @override
  Widget build(BuildContext context) {
    Get.put(Filter());
    return Scaffold(
      drawer: Menu(),
      body: CustomScrollView(
        slivers: [
          CabinetAppBar(),
          SearchSliver(),
          DrugGrid(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed("/add_drug");
          // Navigator.pushNamed(context, "/add_drug");
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
    );
  }
}

class DrugGrid extends StatelessWidget {
  const DrugGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CabinetId cabId = Get.find();
    Filter filter = Get.find();
    return Obx(() => StreamBuilder<List<DrugModel>>(
        stream: DrugRepository(context, cabId.id.value)
            .streamModels(filter: filter.filter.value),
        initialData: [],
        builder: (context, snapshot) {
          return SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children:
                    snapshot.data.map((m) => DrugGridItem(model: m)).toList(),
              ));
        }));
  }
}

class SearchSliver extends StatelessWidget {
  const SearchSliver({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
            SearhCategories(),
          ],
        ),
      ),
    );
  }
}

class SearhCategories extends StatelessWidget {
  const SearhCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
    );
  }
}
