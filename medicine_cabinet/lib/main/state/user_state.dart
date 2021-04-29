import 'package:get/get.dart';

class UserState extends GetxController {
  Rx<String> id = "".obs;
  Rx<String> userId = "".obs;
  Rx<String> name = "".obs;
  Rx<String> email = "".obs;
  Rx<String> openCabinetId = "".obs;
}
