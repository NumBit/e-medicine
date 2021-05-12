import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class ScheduleModel extends Model {
  final String id;
  final String ownerId;
  final String name;
  final String dosage;
  final int count;
  final Timestamp timestamp;

  ScheduleModel(
      {this.id,
      this.ownerId,
      this.name,
      this.dosage,
      this.count,
      this.timestamp})
      : super(id: id);

  ScheduleModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        ownerId = snapshot.data()["owner_id"] ?? "",
        name = snapshot.data()["name"] ?? "",
        dosage = snapshot.data()["dosage"] ?? "",
        count = snapshot.data()["count"] ?? 0,
        timestamp = snapshot.data()["timestamp"] ?? "";

  @override
  Map<String, dynamic> toJson() => {
        if (ownerId != null) "owner_id": ownerId,
        if (name != null) "name": name,
        if (dosage != null) "dossage": dosage,
        if (count != null && count >= 0) "count": count,
        if (timestamp != null) "timestamp": timestamp,
      };
}