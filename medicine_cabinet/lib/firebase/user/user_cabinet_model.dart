import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class UserCabinetModel extends Model {
  final String? id;
  final String? userId;
  final String? userEmail;
  final String? cabinetId;
  final bool? admin;

  const UserCabinetModel(
      {this.id, this.userId, this.cabinetId, this.userEmail, this.admin});

  UserCabinetModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        userId = snapshot.data()["user_id"] as String? ?? "",
        userEmail = snapshot.data()["user_email"] as String? ?? "",
        cabinetId = snapshot.data()["cabinet_id"] as String? ?? "",
        admin = snapshot.data()["admin"] as bool? ?? false;

  UserCabinetModel.fromJson(Map<String, dynamic> data)
      : id = data["id"] as String? ?? "",
        userId = data["user_id"] as String? ?? "",
        userEmail = data["user_email"] as String? ?? "",
        cabinetId = data["cabinet_id"] as String? ?? "",
        admin = data["admin"] as bool? ?? false;

  @override
  Map<String, dynamic> toJson() => {
        if (userId != null) "user_id": userId,
        if (userEmail != null) "user_email": userEmail,
        if (cabinetId != null) "cabinet_id": cabinetId,
        if (admin != null) "admin": admin,
      };

  @override
  String? getId() {
    return id;
  }
}
