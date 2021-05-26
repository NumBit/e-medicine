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

  UserModel(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.profilePicture,
      this.openCabinetId,
      this.notifyCounter})
      : super(id: id);

  UserModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        userId = snapshot.data()["user_id"] ?? "",
        name = snapshot.data()["name"] ?? "",
        email = snapshot.data()["email"] ?? "",
        profilePicture = snapshot.data()["profile_picture"] ?? "",
        openCabinetId = snapshot.data()["default_cabinet"] ?? "",
        notifyCounter = snapshot.data()["notify_counter"] ?? 0;
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
}
