import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class OwnerModel extends Model {
  final String id;
  final String userId;
  final String email;
  final bool isAdmin;

  OwnerModel({this.id, this.userId, this.email, this.isAdmin}) : super(id: id);

  OwnerModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        userId = snapshot.data()["user_id"] ?? "",
        email = snapshot.data()["email"] ?? "",
        isAdmin = snapshot.data()["admin"] ?? false;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "email": email,
        "admin": isAdmin,
      };
}
