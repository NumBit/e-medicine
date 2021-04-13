import 'package:flutter/material.dart';
import 'package:medicine_cabinet/schedule/schedule_item.dart';
import 'package:medicine_cabinet/schedule/week_calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Schedule",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w400,
              fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          WeekCalendar(),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                    ScheduleItem(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
