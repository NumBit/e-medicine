import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  CategoryModel({this.id = "", this.name});

  CategoryModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "";

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
