import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class CabinetRepository extends Repository<CabinetModel> {
  CabinetRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.cabinets),
        );

  @override
  Stream<CabinetModel> streamModel(String? id) {
    return collection.snapshots().map((snap) => snap.docs
        .where((element) => element.id == id)
        .map((e) => CabinetModel.fromMap(
            e as QueryDocumentSnapshot<Map<String, dynamic>>))
        .first);
  }

  @override
  Future<String?> add(CabinetModel model) async {
    DocumentReference cabinet;
    final nameModel = CabinetModel(name: model.name);
    try {
      cabinet = await collection.add(nameModel.toJson());
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
    }
    return cabinet.id;
  }

  @override
  void delete(String? docId) {
    if (docId == null) return;
    collection
        .doc(docId)
        .delete()
        .then((value) => debugPrint("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
    UserCabinetRepository().deleteAll(docId);
  }

  Future<String?> addToAuthUser(CabinetModel model) async {
    DocumentReference cabinet;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    try {
      cabinet = await collection.add(model.toJson());
      await UserCabinetRepository().add(UserCabinetModel(
          userId: user.uid,
          userEmail: user.email,
          cabinetId: cabinet.id,
          admin: true));
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
    }
    return cabinet.id;
  }

  Stream<List<CabinetModel>> streamModels() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();
    return collection
        .where("owner_id", isEqualTo: user.uid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => CabinetModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      }
      return [];
    });
  }

  Stream<int> cabinetCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();
    return UserCabinetRepository()
        .collection
        .where("user_id", isEqualTo: user.uid)
        .snapshots()
        .map((value) {
      return value.size;
    });
  }

  void drugCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final UserState userState = Get.find();
    UserCabinetRepository()
        .collection
        .where("user_id", isEqualTo: user.uid)
        .snapshots()
        .forEach((element) {
      int count = 0;
      element = element as QuerySnapshot<Map<String, dynamic>>;
      element.docs.forEach((e) async {
        final userCabinet = UserCabinetModel.fromMap(e);
        final tmpCount = await DrugRepository(userCabinet.cabinetId).count();
        count += tmpCount;
        userState.drugsCount.value = count;
      });
    });
  }

  void pillCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final UserState userState = Get.find();
    userState.pillCount.value = 0;
    UserCabinetRepository()
        .collection
        .where("user_id", isEqualTo: user.uid)
        .snapshots()
        .forEach((element) {
      element = element as QuerySnapshot<Map<String, dynamic>>;
      element.docs.forEach((e) async {
        final userCabinet = UserCabinetModel.fromMap(e);
        DrugRepository(userCabinet.cabinetId).streamModels().forEach((drugs) {
          drugs.forEach((drug) async {
            final pills = await PackageRepository(drug.id).countPills();
            userState.pillCount.value += pills;
          });
        });
      });
    });
  }
}
