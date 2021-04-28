import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/detail/package_card.dart';

import 'description.dart';
import 'detail_app_bar.dart';

class PackagesList extends StatelessWidget {
  const PackagesList({
    Key key,
    this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      DetailAppBar(
        model: model,
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 250,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          Description(description: model.description),
          Container(
            color: Theme.of(context).primaryColor,
            child: Divider(
              color: Theme.of(context).primaryColorDark,
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
              ],
            ),
          )
        ]),
      )
    ]);
  }
}
