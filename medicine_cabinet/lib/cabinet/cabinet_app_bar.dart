import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/main/cabinet_id.dart';

import 'data/cabinet_model.dart';
import 'data/cabinet_repository.dart';

class CabinetAppBar extends StatelessWidget {
  const CabinetAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CabinetId cabId = Get.find();
    return Obx(
      () => StreamBuilder<CabinetModel>(
        stream: CabinetRepository(context).streamModel(cabId.id.value),
        initialData: CabinetModel(id: "", name: ""),
        builder: (context, snapshot) => SliverAppBar(
          pinned: true,
          floating: true,
          title: Text(
            snapshot.data.name,
            textScaleFactor: 1.23,
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: const FlexibleSpaceBar(
            centerTitle: true,
          ),
          expandedHeight: 120,
          collapsedHeight: 60,
        ),
      ),
    );
  }
}
