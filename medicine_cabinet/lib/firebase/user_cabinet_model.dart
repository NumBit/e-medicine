import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class UserCabinetModel extends Model {
  final String id;
  final String name;
  final String cabinetId;

  UserCabinetModel({this.id = "", this.name, this.cabinetId}) : super(id: id);

  UserCabinetModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "",
        cabinetId = snapshot.data()["cabinet_id"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        if (name != null) "name": name,
        if (cabinetId != null) "cabinet_id": cabinetId,
      };
}
