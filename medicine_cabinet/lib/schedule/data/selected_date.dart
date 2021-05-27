import 'package:get/get.dart';

class SelectedDate extends GetxController {
  Rx<DateTime> date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
}
