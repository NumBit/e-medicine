import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class CabinetModel extends Model {
  final String id;
  final String name;
  final String ownerId;

  CabinetModel({this.id, this.name, this.ownerId}) : super(id: id);

  CabinetModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "",
        ownerId = snapshot.data()["owner_id"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        if (name != null) "name": name,
        if (ownerId != null) "owner_id": ownerId,
      };
}