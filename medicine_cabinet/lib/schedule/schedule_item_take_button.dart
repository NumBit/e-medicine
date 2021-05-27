import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/notifications/notifications.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';

class ScheduleItemTakeButton extends StatelessWidget {
  const ScheduleItemTakeButton({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: model.isTaken!,
      onSelected: (taken) {
        ScheduleRepository()
            .update(ScheduleModel(id: model.id, isTaken: taken));
        if (model.notify!) {
          if (taken)
            cancelNotification(model.notifyId!);
          else
            createNotification(
              model.notifyId!,
              "Time to take ${model.count}x ${model.name}.",
              model.timestamp!.toDate(),
            );
        }
      },
      elevation: 5,
      selectedColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: model.isTaken!
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor,
      ),
      label: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getTimeFromTimestamp(model.timestamp!).format(context),
                  style: TextStyle(
                    color: model.isTaken!
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TimeOfDay getTimeFromTimestamp(Timestamp timestamp) {
  return TimeOfDay.fromDateTime(timestamp.toDate());
}
