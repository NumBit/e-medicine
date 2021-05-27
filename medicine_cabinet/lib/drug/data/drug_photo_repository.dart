import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

import 'drug_photo_model.dart';

class DrugPhotoRepository extends Repository<DrugPhotoModel> {
  final String? drugId;
  DrugPhotoRepository(String? drugId)
      : this.drugId = drugId,
        super(
          FirebaseFirestore.instance.collection(Collections.drugPhotos),
        );

  @override
  Stream<DrugPhotoModel> streamModel(String? id) {
    if (id == null) return Stream.empty();
    return collection
        .where("drug_id", isEqualTo: drugId)
        .orderBy("created_at")
        .snapshots()
        .map((snap) => snap.docs.where((element) => element.id == id).map((e) {
              return DrugPhotoModel.fromMap(
                  e as QueryDocumentSnapshot<Map<String, dynamic>>);
            }).first);
  }

  Stream<List<DrugPhotoModel>> streamModels() {
    return collection
        .where("drug_id", isEqualTo: drugId)
        .orderBy("created_at")
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => DrugPhotoModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      }
      return [];
    });
  }

  Future<List<DrugPhotoModel>> listModels() {
    return collection
        .where("drug_id", isEqualTo: drugId)
        .orderBy("created_at")
        .get()
        .then((snap) => snap.docs
            .map((e) => DrugPhotoModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  void deleteAllDrugPhotos() {
    collection
        .where("drug_id", isEqualTo: drugId)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((e) {
        delete(e.id);
      });
    });
  }

  Future<int> count() async {
    var count = await collection
        .where("drug_id", isEqualTo: drugId)
        .get()
        .then((value) => value.size);
    return count;
  }
}
