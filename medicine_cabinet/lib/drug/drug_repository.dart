import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';

import 'drug_model.dart';

class DrugRepository extends Repository<DrugModel> {
  DrugRepository(BuildContext context, String cabinetId)
      : super(
          context,
          FirebaseFirestore.instance
              .collection(Collections.cabinets)
              .doc(cabinetId)
              .collection(Collections.drugs),
        );

  @override
  Stream<DrugModel> streamModel(String id) {
    throw UnimplementedError();
  }

  Stream<List<DrugModel>> streamModels({String filter = ""}) {
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
  }

  @override
  DrugModel get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
