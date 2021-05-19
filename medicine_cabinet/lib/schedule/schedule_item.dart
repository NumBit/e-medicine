import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
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
          children: [ScheduleActions(model: model)],
        ),
      ),
    );
  }
}

class ScheduleActions extends StatelessWidget {
  const ScheduleActions({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () {
              Get.toNamed("/edit_one_schedule",
                  arguments: model,
                  id: Get.find<NavigationState>().navigatorId.value);
            },
            child: Text("Edit one")),
        TextButton(
            onPressed: () {
              Get.toNamed("/edit_schedule_plan",
                  arguments: model.schedulerId,
                  id: Get.find<NavigationState>().navigatorId.value);
            },
            child: Text("Edit all"))
      ],
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
                DrugNameTitle(model: model),
                DosageAndCount(model: model),
              ],
            ),
          ),
          ScheduleItemTakeButton(model: model),
        ],
      ),
    );
  }
}

class DosageAndCount extends StatelessWidget {
  const DosageAndCount({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Text(
      model.dosage + " x " + model.count.toString(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 18,
          fontWeight: FontWeight.w300),
    );
  }
}

class DrugNameTitle extends StatelessWidget {
  const DrugNameTitle({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Text(
      model.name,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.w300),
    );
  }
}
