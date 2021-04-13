import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/search_bar.dart';
import 'package:medicine_cabinet/main/menu.dart';

import 'chip_filter.dart';
import 'drug_grid_item.dart';

class MedicineCabinetPage extends StatelessWidget {
  const MedicineCabinetPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Medicine cabinet",
                textScaleFactor: 1.23,
                style: TextStyle(color: Colors.white),
              ),
            ),
            expandedHeight: 120,
            collapsedHeight: 60,
          ),
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
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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