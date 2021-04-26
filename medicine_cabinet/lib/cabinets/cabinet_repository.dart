import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/cabinet_model.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/collections.dart';

class CabinetRepository extends Repository<CabinetModel> {
  CabinetRepository(BuildContext context)
      : super(
          context,
          FirebaseFirestore.instance.collection(Collections.cabinetsCollection),
        );

  @override
  Stream<CabinetModel> streamModel(String id) {
    return collection
        .snapshots()
        .map((snap) => snap.docs.map((e) => CabinetModel.fromMap(e)).first);
  }

  Stream<List<CabinetModel>> streamModels() {
    return collection.snapshots().map((snap) {
      return snap.docs.map((e) {
        return CabinetModel.fromMap(e);
      }).toList();
    });
  }
}
