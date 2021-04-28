import 'package:get/get.dart';

class CabinetId extends GetxController {
  var id = "".obs;

  setId(String val) {
    id.value = val;
    update();
  }
}
