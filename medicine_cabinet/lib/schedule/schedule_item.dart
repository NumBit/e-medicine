import 'package:flutter/material.dart';
import 'package:medicine_cabinet/schedule/schedule_item_take_button.dart';

class ScheduleItem extends StatelessWidget {
  final String name;
  final String dosage;
  final int count;
  final String takeWhen;
  final TimeOfDay time = const TimeOfDay(hour: 14, minute: 50);

  const ScheduleItem({
    Key key,
    this.name = "Zodac",
    this.dosage = "50mg",
    this.count = 2,
    this.takeWhen = "After meal",
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
                    name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    dosage + " x " + count.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              ScheduleItemTakeButton(time: time, takeWhen: takeWhen),
            ],
          ),
        ),
      ),
    );
  }
}
