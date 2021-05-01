import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class PackageModel extends Model {
  final String id;
  final String drugId;
  final String dossage;
  final Timestamp expiration;
  final int count;

  PackageModel(
      {this.id, this.drugId, this.dossage, this.expiration, this.count})
      : super(id: id);

  PackageModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        drugId = snapshot.data()["drug_id"] ?? "",
        dossage = snapshot.data()["dossage"] ?? "",
        expiration = snapshot.data()["expiration"] ?? "",
        count = snapshot.data()["count"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        if (drugId != null) "drug_id": drugId,
        if (dossage != null) "dossage": dossage,
        if (expiration != null) "expiration": expiration,
        if (count != null && count >= 0) "count": count,
      };
}
