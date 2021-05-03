import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/detail/package_card.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';

class PackagesList extends StatelessWidget {
  const PackagesList({
    Key key,
    this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PackageModel>>(
        stream: PackageRepository(model.id).streamModels(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();
          return SliverList(
            delegate: SliverChildListDelegate(snapshot.data
                .map((package) => PackageCard(drugId: model.id, model: package))
                .toList()),
          );
        });
  }
}
