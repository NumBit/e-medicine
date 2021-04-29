import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class DrugModel extends Model {
  final String id;
  final String name;
  final String latinName;
  final String description;
  final String icon;
  DateTime createdAt = DateTime.now();

  DrugModel(
      {this.id = "",
      this.name,
      this.latinName,
      this.description,
      this.icon,
      this.createdAt});

  DrugModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "",
        latinName = snapshot.data()["latin_name"] ?? "",
        description = snapshot.data()["description"] ?? "",
        icon = snapshot.data()["icon"] ??
            "{\"codePoint\":60518,\"fontFamily\":\"MaterialIcons\",\"fontPackage\":null,\"matchTextDirection\":false}",
        createdAt = snapshot.data()["created_at"] ?? DateTime.now();

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "latin_name": latinName,
        "description": description,
        "icon": icon,
        "created_at": DateTime.now(),
      };
}
