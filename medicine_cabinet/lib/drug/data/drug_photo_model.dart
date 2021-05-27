import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class DrugPhotoModel extends Model {
  final String id;
  final String? drugId;
  final String? path;
  final Timestamp? createdAt;

  const DrugPhotoModel({this.id = "", this.drugId, this.path, this.createdAt});

  DrugPhotoModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        drugId = snapshot.data()["drug_id"] as String? ?? "",
        path = snapshot.data()["path"] as String? ?? "",
        createdAt =
            snapshot.data()["created_at"] as Timestamp? ?? "" as Timestamp?;

  @override
  Map<String, dynamic> toJson() => {
        if (drugId != null) "drug_id": drugId,
        if (path != null) "path": path,
        if (createdAt != null) "created_at": createdAt,
      };

  @override
  String? getId() {
    return id;
  }
}
