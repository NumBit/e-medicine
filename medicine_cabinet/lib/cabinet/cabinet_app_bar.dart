import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

import 'data/cabinet_model.dart';
import 'data/cabinet_repository.dart';

class CabinetAppBar extends StatelessWidget {
  const CabinetAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserState userState = Get.find();
    return Obx(
      () => StreamBuilder<CabinetModel>(
        stream: CabinetRepository().streamModel(userState.openCabinetId.value),
        initialData: const CabinetModel(id: "", name: ""),
        builder: (context, snapshot) => SliverAppBar(
          leading: InkWell(
            onTap: () {
              final NavigationState nav = Get.find();
              Get.toNamed("/cabinets", id: nav.navigatorId.value);
            },
            child: const Icon(Icons.medical_services_outlined),
          ),
          pinned: true,
          floating: true,
          centerTitle: true,
          title: Text(
            snapshot.data?.name ?? "No cabinet open",
            textScaleFactor: 1.23,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
