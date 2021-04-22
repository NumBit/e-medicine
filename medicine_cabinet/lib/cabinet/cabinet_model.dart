import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class CabinetModel extends Model {
  final String id;
  final String name;

  CabinetModel({this.id, this.name}) : super(id: id);

  CabinetModel.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
