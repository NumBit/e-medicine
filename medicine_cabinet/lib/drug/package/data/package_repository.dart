import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';

class PackageRepository extends Repository<PackageModel> {
  final String drugId;
  PackageRepository(String drugId)
      : this.drugId = drugId,
        super(
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

  void increase(PackageModel model) {
    super.update(PackageModel(id: model.id, count: model.count + 1));
  }

  void decrease(PackageModel model) {
    super.update(PackageModel(id: model.id, count: model.count - 1));
  }

  void deleteAllDrugPackages() {
    collection.where("drug_id", isEqualTo: drugId).snapshots().forEach((snap) {
      snap.docs.forEach((e) {
        delete(e.id);
      });
    });
  }
}
