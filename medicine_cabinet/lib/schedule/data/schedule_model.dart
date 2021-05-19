import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class ScheduleModel extends Model with EventInterface {
  final String id;
  final String ownerId;
  final String schedulerId;
  final String schedulerKey;
  final String name;
  final String dosage;
  final int count;
  final Timestamp timestamp;
  final bool isTaken;

  ScheduleModel(
      {this.id,
      this.ownerId,
      this.schedulerId,
      this.schedulerKey,
      this.name,
      this.dosage,
      this.count,
      this.timestamp,
      this.isTaken})
      : super(id: id);

  ScheduleModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        ownerId = snapshot.data()["owner_id"] ?? "",
        schedulerId = snapshot.data()["scheduler_id"] ?? "",
        schedulerKey = snapshot.data()["scheduler_key"] ?? "",
        name = snapshot.data()["name"] ?? "",
        dosage = snapshot.data()["dosage"] ?? "",
        count = snapshot.data()["count"] ?? 0,
        timestamp = snapshot.data()["timestamp"] ?? "",
        isTaken = snapshot.data()["is_taken"] ?? false;

  @override
  Map<String, dynamic> toJson() => {
        if (ownerId != null) "owner_id": ownerId,
        if (schedulerId != null) "scheduler_id": schedulerId,
        if (schedulerKey != null) "scheduler_key": schedulerKey,
        if (name != null) "name": name,
        if (dosage != null) "dosage": dosage,
        if (count != null && count >= 0) "count": count,
        if (timestamp != null) "timestamp": timestamp,
        if (isTaken != null) "is_taken": isTaken,
      };

  @override
  DateTime getDate() {
    return timestamp.toDate();
  }

  @override
  Widget getDot() {
    return null;
  }

  @override
  Widget getIcon() {
    return null;
  }

  @override
  int getId() {
    return null;
  }

  @override
  String getTitle() {
    return name;
  }
}
