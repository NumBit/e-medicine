import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class ScheduleModel extends Model {
  final String? id;
  final String? ownerId;
  final String? schedulerId;
  final String? schedulerKey;
  final String? name;
  final String? dosage;
  final int? count;
  final Timestamp? timestamp;
  final bool? isTaken;
  final bool? notify;
  final int? notifyId;

  const ScheduleModel(
      {this.id,
      this.ownerId,
      this.schedulerId,
      this.schedulerKey,
      this.name,
      this.dosage,
      this.count,
      this.timestamp,
      this.isTaken,
      this.notify,
      this.notifyId});

  ScheduleModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        ownerId = snapshot.data()["owner_id"] as String? ?? "",
        schedulerId = snapshot.data()["scheduler_id"] as String? ?? "",
        schedulerKey = snapshot.data()["scheduler_key"] as String? ?? "",
        name = snapshot.data()["name"] as String? ?? "",
        dosage = snapshot.data()["dosage"] as String? ?? "",
        count = snapshot.data()["count"] as int? ?? 0,
        timestamp =
            snapshot.data()["timestamp"] as Timestamp? ?? "" as Timestamp?,
        isTaken = snapshot.data()["is_taken"] as bool? ?? false,
        notify = snapshot.data()["notify"] as bool? ?? false,
        notifyId = snapshot.data()["notify_id"] as int? ?? 0;

  @override
  Map<String, dynamic> toJson() => {
        if (ownerId != null) "owner_id": ownerId,
        if (schedulerId != null) "scheduler_id": schedulerId,
        if (schedulerKey != null) "scheduler_key": schedulerKey,
        if (name != null) "name": name,
        if (dosage != null) "dosage": dosage,
        if (count != null && count! >= 0) "count": count,
        if (timestamp != null) "timestamp": timestamp,
        if (isTaken != null) "is_taken": isTaken,
        if (notify != null) "notify": notify,
        if (notifyId != null) "notify_id": notifyId,
      };

  @override
  String? getId() {
    return id;
  }
}
