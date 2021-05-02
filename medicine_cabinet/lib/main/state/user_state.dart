import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';

class UserState extends GetxController {
  Rx<String> id = "".obs;
  Rx<String> userId = "".obs;
  Rx<String> name = "".obs;
  Rx<String> email = "".obs;
  Rx<String> openCabinetId = "".obs;

  void fromModel(UserModel model) {
    id = model.id.obs;
    userId = model.userId.obs;
    name = model.name.obs;
    email = model.email.obs;
    openCabinetId = model.openCabinetId.obs;
  }
}

//_setUserState(UserModel model){
