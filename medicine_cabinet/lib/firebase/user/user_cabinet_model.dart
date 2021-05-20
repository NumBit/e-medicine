import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class UserCabinetModel extends Model {
  final String id;
  final String userId;
  final String userEmail;
  final String cabinetId;
  final bool admin;

  UserCabinetModel(
      {this.id, this.userId, this.cabinetId, this.userEmail, this.admin})
      : super(id: id);

  UserCabinetModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id ?? "",
        userId = snapshot.data()["user_id"] ?? "",
        userEmail = snapshot.data()["user_email"] ?? "",
        cabinetId = snapshot.data()["cabinet_id"] ?? "",
        admin = snapshot.data()["admin"] ?? false;

  @override
  Map<String, dynamic> toJson() => {
        if (userId != null) "user_id": userId,
        if (userEmail != null) "user_email": userEmail,
        if (cabinetId != null) "cabinet_id": cabinetId,
        if (admin != null) "admin": admin,
      };
}
