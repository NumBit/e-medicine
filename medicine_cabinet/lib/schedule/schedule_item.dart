import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/schedule_item_take_button.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleModel model;

  const ScheduleItem({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    model.dosage + " x " + model.count.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              ScheduleItemTakeButton(
                  time: getTimeFromTimestamp(model.timestamp),
                  takeWhen: "Morning"),
            ],
          ),
        ),
      ),
    );
  }
}

TimeOfDay getTimeFromTimestamp(Timestamp timestamp) {
  return TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
}
