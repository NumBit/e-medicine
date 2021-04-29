import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/detail/package_card.dart';

class PackagesList extends StatelessWidget {
  const PackagesList({
    Key key,
    this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        PackageCard(),
        PackageCard(),
        PackageCard(),
        PackageCard(),
        PackageCard(),
        PackageCard(),
        PackageCard(),
      ]),
    );
  }
}
