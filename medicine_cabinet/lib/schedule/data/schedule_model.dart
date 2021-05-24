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

  ScheduleModel(
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
      this.notifyId})
      : super(id: id);

  ScheduleModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        ownerId = snapshot.data()["owner_id"] ?? "",
        schedulerId = snapshot.data()["scheduler_id"] ?? "",
        schedulerKey = snapshot.data()["scheduler_key"] ?? "",
        name = snapshot.data()["name"] ?? "",
        dosage = snapshot.data()["dosage"] ?? "",
        count = snapshot.data()["count"] ?? 0,
        timestamp = snapshot.data()["timestamp"] ?? "" as Timestamp?,
        isTaken = snapshot.data()["is_taken"] ?? false,
        notify = snapshot.data()["notify"] ?? false,
        notifyId = snapshot.data()["notify_id"] ?? 0;

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
}
