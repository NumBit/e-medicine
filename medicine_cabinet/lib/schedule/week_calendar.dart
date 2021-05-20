import 'package:flutter/material.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:table_calendar/table_calendar.dart';

import 'data/selected_date.dart';

class WeekCalendar extends StatefulWidget {
  final List<ScheduleModel>? events;
  const WeekCalendar({
    Key? key,
    this.events,
  }) : super(key: key);

  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  DateTime? _selectedDay;
  var _focusedDay = DateTime.now();
  late ValueNotifier<List<ScheduleModel>> _selectedEvents;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<ScheduleModel> _getEventsForDay(DateTime? day) {
    return widget.events
            ?.where(
                (element) => getDateOnly(element.timestamp!.toDate()) == day)
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    var selectedDate = Get.put(SelectedDate());
    initializeDateFormatting("sk");
    return Material(
      elevation: 10,
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            children: [
              TableCalendar<ScheduleModel>(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                locale: "sk",
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: CalendarFormat.week,
                availableCalendarFormats: {CalendarFormat.week: 'Week'},
                rowHeight: 80,
                eventLoader: (date) => widget.events!
                    .where((e) =>
                        getDateOnly(e.timestamp!.toDate()) ==
                        DateTime(date.year, date.month, date.day))
                    .toList(),
                calendarBuilders:
                    CalendarBuilders(markerBuilder: (context, day, events) {
                  if (events.length <= 0) return null;
                  return Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).errorColor),
                      child: Text(
                        events.length.toString(),
                        textScaleFactor: 0.8,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
                calendarStyle: CalendarStyle(
                    defaultDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                        )),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    markersAlignment: Alignment.bottomRight,
                    defaultTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                    selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    weekendTextStyle: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColorDark,
                    )),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  selectedDate.date.value = DateTime(
                      selectedDay.year, selectedDay.month, selectedDay.day);
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = selectedDay;
                  });
                },
              ),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}

DateTime getDateOnly(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
