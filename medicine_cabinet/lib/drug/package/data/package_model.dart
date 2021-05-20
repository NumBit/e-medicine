import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class PackageModel extends Model {
  final String? id;
  final String? drugId;
  final String? dosage;
  final Timestamp? expiration;
  final int? count;

  PackageModel(
      {this.id, this.drugId, this.dosage, this.expiration, this.count})
      : super(id: id);

  PackageModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id ?? "",
        drugId = snapshot.data()["drug_id"] ?? "",
        dosage = snapshot.data()["dosage"] ?? "",
        expiration = snapshot.data()["expiration"] ?? "" as Timestamp?,
        count = snapshot.data()["count"] ?? 0;

  @override
  Map<String, dynamic> toJson() => {
        if (drugId != null) "drug_id": drugId,
        if (dosage != null) "dosage": dosage,
        if (expiration != null) "expiration": expiration,
        if (count != null && count! >= 0) "count": count,
      };
}
