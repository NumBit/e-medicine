import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class CategoryModel extends Model {
  final String id;
  final String name;
  CategoryModel({this.id = "", this.name});

  CategoryModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
