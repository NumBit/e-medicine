import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({
    Key key,
  }) : super(key: key);

  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
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
          markedDateShowIcon: true,
          markedDatesMap: _markedDateMap,
          markedDateMoreShowTotal: true,
          markedDateIconMaxShown: 0,
          onDayPressed: (date, events) => showAboutDialog(
              context: context,
              children: [
                Text(date.toString()),
                Text(events.asMap().toString())
              ]),
        ),
      ),
    );
  }
}

EventList<Event> _markedDateMap = new EventList<Event>(
  events: {
    new DateTime(2021, 4, 29): [
      new Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2021, 4, 28),
        title: 'Event 3',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2021, 4, 28),
        title: 'Event 4',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 4',
        icon: _eventIcon,
      ),
    ],
    new DateTime(2021, 4, 25): [
      new Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 1',
        icon: _eventIcon,
      )
    ],
    new DateTime(2021, 4, 25): [
      Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 1',
        icon: _eventIcon,
      ),
    ],
    new DateTime(2021, 4, 30): [
      new Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2021, 4, 29),
        title: 'Event 2',
        icon: _eventIcon,
      ),
    ],
  },
);

Widget _eventIcon = new Container(
  decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.blue, width: 2.0)),
  child: new Icon(
    Icons.person,
    color: Colors.amber,
  ),
);


