import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

import 'drug_model.dart';

class DrugRepository extends Repository<DrugModel> {
  final String? cabinetId;
  DrugRepository(String? cabinetId)
      : this.cabinetId = cabinetId,
        super(
          FirebaseFirestore.instance.collection(Collections.drugs),
        );

  @override
  Stream<DrugModel> streamModel(String? id) {
    if (id == null) return Stream.empty();
    return collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .map((snap) => snap.docs.where((element) => element.id == id).map((e) {
              return DrugModel.fromMap(
                  e as QueryDocumentSnapshot<Map<String, dynamic>>);
            }).first);
  }

  Stream<List<DrugModel>> streamModels({String filter = ""}) {
    return collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .map((snap) {
      return snap.docs
          .where((element) => DrugModel.fromMap(
                  element as QueryDocumentSnapshot<Map<String, dynamic>>)
              .name!
              .toLowerCase()
              .contains(filter.toLowerCase()))
          .map((e) {
        return DrugModel.fromMap(
            e as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  void deleteAllDrugsInCabinet() {
    collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((e) {
        delete(e.id);
        PackageRepository(e.id).deleteAllDrugPackages();
      });
    });
  }

  void delete(String? docId) {
    collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
    PackageRepository(docId).deleteAllDrugPackages();
  }

  Future<int> count() async {
    var count = await collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .get()
        .then((value) => value.size);
    return count;
  }
}
