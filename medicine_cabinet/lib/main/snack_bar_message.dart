import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBarMessage(String title, String message, {int timeout = 3}) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.all(10),
      duration: Duration(seconds: timeout));
}
