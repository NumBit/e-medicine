import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/cabinets/edit_cabinet.dart';
import 'package:medicine_cabinet/cabinets/share_cabinet.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class CabinetCard extends StatelessWidget {
  final UserCabinetModel model;
  const CabinetCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState userState = Get.find();
    return StreamBuilder<CabinetModel>(
      stream: CabinetRepository().streamModel(model.cabinetId),
      builder: (context, snapshot) {
        if (snapshot.data == null) return LoadingWidget();
        var cabinet = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Card(
            elevation: 5,
            child: ExpansionTile(
              key: ObjectKey(cabinet.id),
              leading: Icon(
                Icons.medical_services_outlined,
                color: Theme.of(context).primaryColorDark,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cabinet.name ?? "Not set",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  if (userState.openCabinetId.value == cabinet.id)
                    Tooltip(
                      message: "Opened cabinet",
                      child: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColorDark,
                        size: 30,
                      ),
                    )
                ],
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.dialog(EditCabinet(model: cabinet));
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        )),
                    TextButton(
                        onPressed: () {
                          Get.dialog(ShareCabinet(model: cabinet));
                        },
                        child: Text(
                          "Share",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        )),
                    TextButton(
                        onPressed: () {
                          NavigationState nav = Get.find();
                          userState.openCabinetId.value = cabinet.id ?? "";
                          UserRepository().update(UserModel(
                            id: userState.id.value,
                            openCabinetId: cabinet.id,
                          ));
                          Get.offAllNamed("/", id: nav.navigatorId.value);
                        },
                        child: Text(
                          "Open",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
