import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';

class UserState extends GetxController {
  Rx<String> id = "".obs;
  Rx<String> userId = "".obs;
  Rx<String> name = "".obs;
  Rx<String> email = "".obs;
  Rx<String> openCabinetId = "".obs;
  Rx<int> drugsCount = 0.obs;
  Rx<bool> drugCountLock = false.obs;
  Rx<int> pillCount = 0.obs;
  Rx<bool> pillCountLock = false.obs;

  void fromModel(UserModel model) {
    id.value = model.id!;
    userId.value = model.userId!;
    name.value = model.name!;
    email.value = model.email!;
    openCabinetId.value = model.openCabinetId!;
  }
}
