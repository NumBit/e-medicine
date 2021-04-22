import 'package:cloud_firestore/cloud_firestore.dart';

class DrugModel {
  final String id;
  final String name;
  final String latinName;
  final String description;
  final String icon;

  DrugModel(
      {this.id = "", this.name, this.latinName, this.description, this.icon});

  DrugModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "",
        latinName = snapshot.data()["latin_name"] ?? "",
        description = snapshot.data()["description"] ?? "",
        icon = snapshot.data()["icon"] ?? ""; //TODO default icon path

  Map<String, dynamic> toJson() => {
        "name": name,
        "latin_name": latinName,
        "description": description,
        "icon": icon
      };
}
