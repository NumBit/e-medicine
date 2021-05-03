import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

import 'data/cabinet_model.dart';
import 'data/cabinet_repository.dart';

class CabinetAppBar extends StatelessWidget {
  const CabinetAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState userState = Get.find();
    return Obx(
      () => StreamBuilder<CabinetModel>(
        stream: CabinetRepository()
            .streamModel(userState.openCabinetId.value),
        initialData: CabinetModel(id: "", name: ""),
        builder: (context, snapshot) => SliverAppBar(
          pinned: true,
          floating: true,
          centerTitle: true,
          title: Text(
            snapshot.data?.name,
            textScaleFactor: 1.23,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
