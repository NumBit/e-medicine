import 'package:cloud_firestore/cloud_firestore.dart';

class CabinetModel {
  final String name;
  CabinetModel({this.name});

  factory CabinetModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data();

    return CabinetModel(
      name: data['name'] ?? '',
    );
  }
}
