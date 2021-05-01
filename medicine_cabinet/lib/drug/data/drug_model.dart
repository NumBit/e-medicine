import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class DrugModel extends Model {
  final String id;
  final String cabinetId;
  final String name;
  final String substance;
  final String description;
  final String icon;
  final Timestamp createdAt;

  DrugModel(
      {this.id = "",
      this.cabinetId,
      this.name,
      this.substance,
      this.description,
      this.icon,
      this.createdAt});

  DrugModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        cabinetId = snapshot.data()["cabinet_id"] ?? "",
        name = snapshot.data()["name"] ?? "",
        substance = snapshot.data()["substance"] ?? "",
        description = snapshot.data()["description"] ?? "",
        icon = snapshot.data()["icon"] ??
            "{\"codePoint\":60518,\"fontFamily\":\"MaterialIcons\",\"fontPackage\":null,\"matchTextDirection\":false}",
        createdAt = snapshot.data()["created_at"] ?? Timestamp.now();

  @override
  Map<String, dynamic> toJson() => {
        if (cabinetId != null) "cabinet_id": cabinetId,
        if (name != null) "name": name,
        if (substance != null) "substance": substance,
        if (description != null) "description": description,
        if (icon != null) "icon": icon,
        if (createdAt != null) "created_at": Timestamp.now(),
        "edited_at": Timestamp.now(),
      };
}
