import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_model.dart';

class SchedulerRepository extends Repository<SchedulerModel> {
  SchedulerRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.scheduler),
        );

  @override
  Stream<SchedulerModel> streamModel(String? id) {
    return collection.snapshots().map((snap) => snap.docs
        .where((element) => element.id == id)
        .map((e) => SchedulerModel.fromMap(
            e as QueryDocumentSnapshot<Map<String, dynamic>>))
        .first);
  }

  @override
  Future<String?> add(SchedulerModel model) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    DocumentReference cabinet;
    final item = SchedulerModel(
        ownerId: user.uid,
        schedulerKey: model.schedulerKey,
        name: model.name,
        dosage: model.dosage,
        count: model.count,
        repeatType: model.repeatType,
        repeatTimes: model.repeatTimes,
        dayFrom: model.dayFrom,
        dayTo: model.dayTo,
        timeFrom: model.timeFrom,
        timeTo: model.timeTo,
        notify: model.notify);
    try {
      cabinet = await collection.add(item.toJson());
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
    }
    return cabinet.id;
  }

  @override
  void delete(String? docId) {
    collection
        .doc(docId)
        .delete()
        .then((value) => debugPrint("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
  }

  Stream<List<SchedulerModel>> streamModels() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();
    return collection
        .where("owner_id", isEqualTo: user.uid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => SchedulerModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      }
      return [];
    });
  }
}
