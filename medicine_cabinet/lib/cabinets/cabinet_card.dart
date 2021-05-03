import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';
import 'package:medicine_cabinet/cabinets/edit_cabinet.dart';
import 'package:medicine_cabinet/cabinets/share_cabinet.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class CabinetCard extends StatelessWidget {
  final UserCabinetModel model;
  const CabinetCard({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState userState = Get.find();
    return StreamBuilder<CabinetModel>(
        stream: CabinetRepository().streamModel(model.cabinetId),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Card(
              elevation: 5,
              child: ExpansionTile(
                key: ObjectKey(snapshot.data.id),
                leading: Icon(
                  Icons.medical_services_outlined,
                  color: Theme.of(context).primaryColorDark,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        snapshot.data.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    if (userState.openCabinetId.value == snapshot.data.id)
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
                            Get.dialog(EditCabinet(model: snapshot.data));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.dialog(ShareCabinet(model: snapshot.data));
                          },
                          child: Text(
                            "Share",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          )),
                      TextButton(
                          onPressed: () {
                            userState.openCabinetId.value = snapshot.data.id;
                            print(userState);
                            UserRepository().update(UserModel(
                              id: userState.id.value,
                              openCabinetId: snapshot.data.id,
                            ));
                            Get.until(ModalRoute.withName("/"));
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
        });
  }
}
