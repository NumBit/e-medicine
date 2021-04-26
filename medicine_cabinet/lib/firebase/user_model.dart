import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class UserModel extends Model {
  final String id;
  final String name;
  final String defaultCabinet;

  UserModel({this.id, this.name, this.defaultCabinet}) : super(id: id);

  UserModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        name = snapshot.data()["name"] ?? "",
        defaultCabinet = snapshot.data()["default_cabinet"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "default_cabinet": defaultCabinet,
      };
}
