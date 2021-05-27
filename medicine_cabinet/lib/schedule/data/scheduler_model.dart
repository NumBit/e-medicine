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
  final bool? notify;

  const SchedulerModel(
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
      this.timeTo,
      this.notify});

  SchedulerModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        ownerId = snapshot.data()["owner_id"] as String? ?? "",
        schedulerKey = snapshot.data()["scheduler_key"] as String? ?? "",
        name = snapshot.data()["name"] as String? ?? "",
        dosage = snapshot.data()["dosage"] as String? ?? "",
        count = snapshot.data()["count"] as int? ?? 0,
        repeatType = snapshot.data()["repeat_type"] as String? ?? "",
        repeatTimes = snapshot.data()["repeat_times"] as int? ?? 0,
        notify = snapshot.data()["notify"] as bool? ?? false,
        dayFrom = snapshot.data()["dayFrom"] as Timestamp? ?? "" as Timestamp?,
        dayTo = snapshot.data()["dayTo"] as Timestamp? ?? "" as Timestamp?,
        timeFrom = TimeOfDay(
            hour: snapshot.data()["timeFromH"] as int? ?? 0,
            minute: snapshot.data()["timeFromM"] as int? ?? 0),
        timeTo = TimeOfDay(
          hour: snapshot.data()["timeToH"] as int? ?? 0,
          minute: snapshot.data()["timeToM"] as int? ?? 0,
        );

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
        if (notify != null) "notify": notify,
      };

  @override
  String? getId() {
    return id;
  }
}
