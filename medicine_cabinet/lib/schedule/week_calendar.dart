import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: CalendarCarousel(
          locale: "sk",
          firstDayOfWeek: 1,
          selectedDayButtonColor: Theme.of(context).primaryColorDark,
          selectedDayBorderColor: Theme.of(context).primaryColorDark,
          todayBorderColor: Colors.grey,
          todayButtonColor: Colors.grey,
          weekdayTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          daysTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark),
          selectedDayTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          todayTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark),
          weekendTextStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          headerTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          iconColor: Colors.white,
          weekFormat: true,
          height: 180,
        ),
      ),
    );
  }
}
