import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class SchedulerModel extends Model {
  final String id;
  final String ownerId;
  final String name;
  final String dosage;
  final int count;
  final Timestamp dayFrom;
  final Timestamp dayTo;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;

  SchedulerModel(
      {this.id,
      this.ownerId,
      this.name,
      this.dosage,
      this.count,
      this.dayFrom,
      this.dayTo,
      this.timeFrom,
      this.timeTo})
      : super(id: id);

  SchedulerModel.fromMap(DocumentSnapshot snapshot)
      : id = snapshot.id ?? "",
        ownerId = snapshot.data()["owner_id"] ?? "",
        name = snapshot.data()["name"] ?? "",
        dosage = snapshot.data()["dosage"] ?? "",
        count = snapshot.data()["count"] ?? 0,
        dayFrom = snapshot.data()["dayFrom"] ?? "",
        dayTo = snapshot.data()["dayTo"] ?? "",
        timeFrom = TimeOfDay(
            hour: snapshot.data()["timeFromH"] ?? 0,
            minute: snapshot.data()["timeFromM"] ?? 0),
        timeTo = TimeOfDay(
            hour: snapshot.data()["timeToH"] ?? 0,
            minute: snapshot.data()["timeToM"] ?? 0);

  @override
  Map<String, dynamic> toJson() => {
        if (ownerId != null) "owner_id": ownerId,
        if (name != null) "name": name,
        if (dosage != null) "dosage": dosage,
        if (count != null && count >= 0) "count": count,
        if (dayFrom != null) "dayFrom": dayFrom,
        if (dayTo != null) "dayTo": dayTo,
        if (timeFrom != null) "timeFromH": timeFrom.hour,
        if (timeFrom != null) "timeFromM": timeFrom.minute,
        if (timeTo != null) "timeToH": timeTo.hour,
        if (timeTo != null) "timeToM": timeTo.minute,
      };
}
