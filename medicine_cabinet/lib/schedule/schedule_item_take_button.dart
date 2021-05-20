import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      onSelected: (_) {
        ScheduleRepository()
            .update(ScheduleModel(id: model.id, isTaken: !model.isTaken!));
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
            // if (model.isTaken)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 8.0),
            //     child: Icon(
            //       Icons.check_circle,
            //       size: 30,
            //       color: model.isTaken
            //           ? Theme.of(context).primaryColorDark
            //           : Colors.white,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

TimeOfDay getTimeFromTimestamp(Timestamp timestamp) {
  return TimeOfDay.fromDateTime(timestamp.toDate());
}
