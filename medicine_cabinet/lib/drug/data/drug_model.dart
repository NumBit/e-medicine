import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class DrugModel extends Model {
  final String id;
  final String? cabinetId;
  final String? name;
  final String? substance;
  final String? description;
  final String? icon;
  final Timestamp? createdAt;

  const DrugModel(
      {this.id = "",
      this.cabinetId,
      this.name,
      this.substance,
      this.description,
      this.icon,
      this.createdAt});

  DrugModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        cabinetId = snapshot.data()["cabinet_id"] as String? ?? "",
        name = snapshot.data()["name"] as String? ?? "",
        substance = snapshot.data()["substance"] as String? ?? "",
        description = snapshot.data()["description"] as String? ?? "",
        icon = snapshot.data()["icon"] as String? ??
            '{"codePoint":60518,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}',
        createdAt =
            snapshot.data()["created_at"] as Timestamp? ?? "" as Timestamp?;

  @override
  Map<String, dynamic> toJson() => {
        if (cabinetId != null) "cabinet_id": cabinetId,
        if (name != null) "name": name,
        if (substance != null) "substance": substance,
        if (description != null) "description": description,
        if (icon != null) "icon": icon,
        if (createdAt != null) "created_at": createdAt,
        "edited_at": Timestamp.now(),
      };

  @override
  String? getId() {
    return id;
  }
}
