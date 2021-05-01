import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';

class DrugRepository extends Repository<PackageModel> {
  final String drugId;
  DrugRepository(BuildContext context, String drugId)
      : this.drugId = drugId,
        super(
          context,
          FirebaseFirestore.instance.collection(Collections.packages),
        );

  @override
  Stream<PackageModel> streamModel(String id) {
    return collection
        .where("drug_id", isEqualTo: drugId)
        .snapshots()
        .map((snap) => snap.docs.where((element) => element.id == id).map((e) {
              return PackageModel.fromMap(e);
            }).first);
  }

  Stream<List<PackageModel>> streamModels({String filter = ""}) {
    return collection
        .where("drug_id", isEqualTo: drugId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((e) {
        return PackageModel.fromMap(e);
      }).toList();
    });
  }

  Future<void> increase(PackageModel model) {
    return super.update(PackageModel(id: model.id, count: model.count + 1));
  }

  Future<void> decrease(PackageModel model) {
    return super.update(PackageModel(id: model.id, count: model.count - 1));
  }
}
