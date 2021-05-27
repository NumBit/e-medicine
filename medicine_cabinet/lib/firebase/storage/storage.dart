import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

import '../../main/snack_bar_message.dart';

class Storage {
  Future<bool> uploadFile(String filePath, String fileTarget) async {
    final File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(fileTarget)
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      snackBarMessage("Upload failed", "Please try again later");
      debugPrint("Upload failed: $e");
      return false;
    }
    return true;
  }

  Future<String> getLink(String filePath) async {
    String ref;
    try {
      ref = await firebase_storage.FirebaseStorage.instance
          .ref(filePath)
          .getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      debugPrint("Getting link failed: $e");
      return "https://firebasestorage.googleapis.com/v0/b/e-medicine-3338c.appspot.com/o/empty.jpg?alt=media&token=53f714f3-ebe5-4146-bd07-d0f47a30fcba";
    }
    return ref;
  }

  Future<bool> downloadFile(String filePath, String fileTarget) async {
    final File downloadToFile = File(fileTarget);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(filePath)
          .writeToFile(downloadToFile);
    } on firebase_core.FirebaseException catch (e) {
      snackBarMessage("Download failed", "Please try again later");
      debugPrint("Download failed: $e");
      return false;
    }
    return true;
  }

  Future<bool> deleteFile(String? filePath) async {
    if (filePath == null) return false;
    try {
      await firebase_storage.FirebaseStorage.instance.ref(filePath).delete();
    } on firebase_core.FirebaseException catch (e) {
      snackBarMessage("Delete failed", "Please try again later");
      debugPrint("Delete failed: $e");
      return false;
    }
    return true;
  }
}
