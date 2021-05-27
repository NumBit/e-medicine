import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class UserModel extends Model {
  final String? id;
  final String? userId;
  final String? name;
  final String? email;
  final String? profilePicture;
  final String? openCabinetId;
  final int? notifyCounter;
  //final List<String> cabinets;

  const UserModel(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.profilePicture,
      this.openCabinetId,
      this.notifyCounter});

  UserModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        userId = snapshot.data()["user_id"] as String? ?? "",
        name = snapshot.data()["name"] as String? ?? "",
        email = snapshot.data()["email"] as String? ?? "",
        profilePicture = snapshot.data()["profile_picture"] as String? ?? "",
        openCabinetId = snapshot.data()["default_cabinet"] as String? ?? "",
        notifyCounter = snapshot.data()["notify_counter"] as int? ?? 0;
  //cabinets = snapshot.data()["cabinets"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        if (userId != null) "user_id": userId,
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (profilePicture != null) "profile_picture": profilePicture,
        if (openCabinetId != null) "default_cabinet": openCabinetId,
        if (notifyCounter != null) "notify_counter": notifyCounter,
        //if (cabinets != null) "cabinets": cabinets,
      };

  @override
  String? getId() {
    return id;
  }
}
