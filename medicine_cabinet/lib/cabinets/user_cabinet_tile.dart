import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class UserCabinetTile extends StatelessWidget {
  final UserCabinetModel model;
  const UserCabinetTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.userEmail ?? "Not set"),
      trailing: Tooltip(
        message: "Cancel sharing this cabinet",
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            final UserState user = Get.find();
            if (model.cabinetId == user.openCabinetId.value &&
                user.userId.value == model.userId) {
              snackBarMessage(
                  "Cannot delete open cabinet", "Open other cabinet first");
            } else if (user.userId.value == model.userId) {
              UserCabinetRepository().delete(model.id);
              Get.back();
            } else {
              UserCabinetRepository().delete(model.id);
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.cancel),
          ),
        ),
      ),
    );
  }
}
