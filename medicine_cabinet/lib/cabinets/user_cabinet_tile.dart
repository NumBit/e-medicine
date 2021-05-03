import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class UserCabinetTile extends StatelessWidget {
  final UserCabinetModel model;
  const UserCabinetTile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = Get.find<UserState>();
    return ListTile(
      title: Text(model.userEmail),
      trailing: (userState.openCabinetId.value == model.id)
          ? Tooltip(
              message: "Cancel sharing this cabinet",
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => UserCabinetRepository().delete(model.id),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.cancel),
                ),
              ),
            )
          : null,
    );
  }
}
