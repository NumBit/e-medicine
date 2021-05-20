import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/model.dart';

class SchedulerModel extends Model {
  final String? id;
  final String? ownerId;
  final String? schedulerKey;
  final String? name;
  final String? dosage;
  final int? count;
  final String? repeatType;
  final int? repeatTimes;
  final Timestamp? dayFrom;
  final Timestamp? dayTo;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeTo;

  SchedulerModel(
      {this.id,
      this.ownerId,
      this.schedulerKey,
      this.name,
      this.dosage,
      this.count,
      this.repeatType,
      this.repeatTimes,
      this.dayFrom,
      this.dayTo,
      this.timeFrom,
      this.timeTo})
      : super(id: id);

  SchedulerModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        ownerId = snapshot.data()["owner_id"] ?? "",
        schedulerKey = snapshot.data()["scheduler_key"] ?? "",
        name = snapshot.data()["name"] ?? "",
        dosage = snapshot.data()["dosage"] ?? "",
        count = snapshot.data()["count"] ?? 0,
        repeatType = snapshot.data()["repeat_type"] ?? "",
        repeatTimes = snapshot.data()["repeat_times"] ?? 0,
        dayFrom = snapshot.data()["dayFrom"] ?? "" as Timestamp?,
        dayTo = snapshot.data()["dayTo"] ?? "" as Timestamp?,
        timeFrom = TimeOfDay(
            hour: snapshot.data()["timeFromH"] ?? 0,
            minute: snapshot.data()["timeFromM"] ?? 0),
        timeTo = TimeOfDay(
            hour: snapshot.data()["timeToH"] ?? 0,
            minute: snapshot.data()["timeToM"] ?? 0);

  @override
  Map<String, dynamic> toJson() => {
        if (ownerId != null) "owner_id": ownerId,
        if (schedulerKey != null) "scheduler_key": schedulerKey,
        if (name != null) "name": name,
        if (dosage != null) "dosage": dosage,
        if (repeatType != null) "repeat_type": repeatType,
        if (repeatTimes != null && repeatTimes! >= 0)
          "repeat_times": repeatTimes,
        if (count != null && count! >= 0) "count": count,
        if (dayFrom != null) "dayFrom": dayFrom,
        if (dayTo != null) "dayTo": dayTo,
        if (timeFrom != null) "timeFromH": timeFrom!.hour,
        if (timeFrom != null) "timeFromM": timeFrom!.minute,
        if (timeTo != null) "timeToH": timeTo!.hour,
        if (timeTo != null) "timeToM": timeTo!.minute,
      };
}
