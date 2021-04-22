import 'package:cloud_firestore/cloud_firestore.dart';

class CabinetModel {
  final String id;
  final String name;

  CabinetModel({this.id = "", this.name});

  CabinetModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "";

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
