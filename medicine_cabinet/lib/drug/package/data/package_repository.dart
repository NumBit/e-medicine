import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';

class PackageRepository extends Repository<PackageModel> {
  final String? drugId;
  PackageRepository(this.drugId)
      : super(
          FirebaseFirestore.instance.collection(Collections.packages),
        );

  @override
  Stream<PackageModel?> streamModel(String? id) {
    if (id == null) return const Stream.empty();
    return collection
        .where("drug_id", isEqualTo: drugId)
        .snapshots()
        .map((snap) => snap.docs.where((element) => element.id == id).map((e) {
              return PackageModel.fromMap(
                  e as QueryDocumentSnapshot<Map<String, dynamic>>);
            }).first);
  }

  Stream<List<PackageModel>> streamModels({String filter = ""}) {
    return collection
        .where("drug_id", isEqualTo: drugId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((e) {
        return PackageModel.fromMap(
            e as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  void increase(PackageModel model) {
    super.update(PackageModel(id: model.id, count: model.count! + 1));
  }

  void decrease(PackageModel model) {
    super.update(PackageModel(id: model.id, count: model.count! - 1));
  }

  void deleteAllDrugPackages() {
    collection.where("drug_id", isEqualTo: drugId).snapshots().forEach((snap) {
      snap.docs.forEach((e) {
        delete(e.id);
      });
    });
  }

  Future<int> count() async {
    final count = await collection
        .where("drug_id", isEqualTo: drugId)
        .get()
        .then((value) => value.size);
    return count;
  }

  Stream<int> countPillsStream() {
    final count = collection
        .where("drug_id", isEqualTo: drugId)
        .snapshots()
        .map((element) {
      element = element as QuerySnapshot<Map<String, dynamic>>;
      int pills = 0;
      element.docs.forEach((e) {
        final package = PackageModel.fromMap(e);
        pills += package.count ?? 0;
      });
      return pills;
    });
    return count;
  }

  Future<int> countPills() async {
    final count = await collection
        .where("drug_id", isEqualTo: drugId)
        .get()
        .then((element) {
      element = element as QuerySnapshot<Map<String, dynamic>>;
      int pills = 0;
      element.docs.forEach((e) {
        final package = PackageModel.fromMap(e);
        pills += package.count ?? 0;
      });
      return pills;
    });
    return count;
  }
}
