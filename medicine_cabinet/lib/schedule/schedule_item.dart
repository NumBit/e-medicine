import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/edit_one_schedule.dart';
import 'package:medicine_cabinet/schedule/edit_schedule_plan.dart';
import 'package:medicine_cabinet/schedule/schedule_item_take_button.dart';

import 'my_expansion_tile.dart';

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
        child: MyExpansionTile(
          key: Key(model.id),
          title: ScheduleCardTitle(model: model),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.to(EditOneSchedule(model: model),
                          id: Get.find<NavigationState>().navigatorId.value);
                    },
                    child: Text("Edit one")),
                TextButton(
                    onPressed: () {
                      Get.to(EditSchedulePlan(schedulerId: model.schedulerId),
                          id: Get.find<NavigationState>().navigatorId.value);
                    },
                    child: Text("Edit all"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ScheduleCardTitle extends StatelessWidget {
  const ScheduleCardTitle({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
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
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          ScheduleItemTakeButton(
              time: getTimeFromTimestamp(model.timestamp), takeWhen: "Morning"),
        ],
      ),
    );
  }
}

TimeOfDay getTimeFromTimestamp(Timestamp timestamp) {
  return TimeOfDay.fromDateTime(timestamp.toDate());
}
