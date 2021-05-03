import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class UserCabinetRepository extends Repository<UserCabinetModel> {
  UserCabinetRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.userCabinet),
        );

  @override
  Stream<UserCabinetModel> streamModel(String id) {
    return collection
        .snapshots()
        .map((snap) => snap.docs.map((e) => UserCabinetModel.fromMap(e)).first);
  }

  Stream<List<UserCabinetModel>> getMyCabinets() {
    var myUid = FirebaseAuth.instance.currentUser.uid;
    return collection
        .where("user_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => UserCabinetModel.fromMap(e)).toList();
      }
      return [];
    });
  }

  Stream<List<UserCabinetModel>> getCabinetUsers(String cabinetId) {
    return collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => UserCabinetModel.fromMap(e)).toList();
      }
      return [];
    });
  }

  Future<bool> addByEmail(String email, String cabinetId) async {
    var user = await UserRepository().getByEmail(email);
    if (user == null) {
      snackBarMessage("User not found", "Check email format");
      return false;
    }
    add(UserCabinetModel(
        cabinetId: cabinetId,
        userId: user.userId,
        userEmail: user.email,
        admin: false));
    snackBarMessage("Share added", email);
    return true;
  }
}
