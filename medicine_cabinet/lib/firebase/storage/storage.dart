import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../../main/snack_bar_message.dart';

Future<bool> uploadFile(String filePath, String fileTarget) async {
  File file = File(filePath);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(fileTarget)
        .putFile(file);
  } on firebase_core.FirebaseException catch (e) {
    snackBarMessage("Upload failed", "Please try again later");
    print("Upload failed: " + e.toString());
    return false;
  }
  return true;
}

Future<bool> downloadFileExample(String filePath, String fileTarget) async {
  File downloadToFile = File(fileTarget);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(filePath)
        .writeToFile(downloadToFile);
  } on firebase_core.FirebaseException catch (e) {
    snackBarMessage("Download failed", "Please try again later");
    print("Download failed: " + e.toString());
    return false;
  }
  return true;
}
