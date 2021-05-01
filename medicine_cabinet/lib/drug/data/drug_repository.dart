import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';

import 'drug_model.dart';

class DrugRepository extends Repository<DrugModel> {
  final String cabinetId;
  DrugRepository(BuildContext context, String cabinetId)
      : this.cabinetId = cabinetId,
        super(
          context,
          FirebaseFirestore.instance.collection(Collections.drugs),
        );

  @override
  Stream<DrugModel> streamModel(String id) {
    return collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .map((snap) => snap.docs.where((element) => element.id == id).map((e) {
              return DrugModel.fromMap(e);
            }).first);
  }

  Stream<List<DrugModel>> streamModels({String filter = ""}) {
    return collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .map((snap) {
      return snap.docs
          .where((element) => element
              .data()['name']
              .toString()
              .toLowerCase()
              .contains(filter.toLowerCase()))
          .map((e) {
        return DrugModel.fromMap(e);
      }).toList();
    });
    /*
    return collection.snapshots().map((snap) {
      return snap.docs
          .where((element) => element
              .data()['name']
              .toString()
              .toLowerCase()
              .contains(filter.toLowerCase()))
          .map((e) {
        return DrugModel.fromMap(e);
      }).toList();
    });
    */
  }
}
