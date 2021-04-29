import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class UserModel extends Model {
  final String id;
  final String userId;
  final String name;
  final String email;
  final String openCabinetId;

  UserModel({this.id, this.userId, this.name, this.email, this.openCabinetId})
      : super(id: id);

  UserModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        userId = snapshot.data()["user_id"] ?? "",
        name = snapshot.data()["name"] ?? "",
        email = snapshot.data()["email"] ?? "",
        openCabinetId = snapshot.data()["default_cabinet"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        if (userId != null) "user_id": userId,
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (openCabinetId != null) "default_cabinet": openCabinetId,
      };
}
