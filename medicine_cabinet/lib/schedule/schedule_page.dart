import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/error/loading_page.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/create_schedule.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/data/selected_date.dart';
import 'package:medicine_cabinet/schedule/schedule_item.dart';
import 'package:medicine_cabinet/schedule/week_calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = Get.put(SelectedDate());
    return Scaffold(
      appBar: _buildSchedulePageAppBar(context),
      floatingActionButton: AddScheduleButton(date: date),
      body: StreamBuilder<List<ScheduleModel>>(
          stream: ScheduleRepository().streamModels(),
          builder: (context, schedules) {
            if (!schedules.hasData) return LoadingPage();
            var events = listToEventList(schedules.data);
            return Column(
              children: [
                WeekCalendar(events: events),
                Expanded(
                  child: Container(
                    child: Obx(() {
                      var schedulesList = events
                          .getEvents(date.date.value)
                          .map((e) => ScheduleItem(model: e))
                          .toList();
                      schedulesList.sort((a, b) =>
                          a.model.timestamp.compareTo(b.model.timestamp));
                      return ListView(
                        children: schedulesList,
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  AppBar _buildSchedulePageAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Schedule",
        style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w400,
            fontSize: 30),
      ),
    );
  }
}

class AddScheduleButton extends StatelessWidget {
  const AddScheduleButton({
    Key key,
    @required this.date,
  }) : super(key: key);

  final SelectedDate date;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        NavigationState nav = Get.find();

        Get.to(CreateSchedule(date: date.date.value),
            id: nav.navigatorId.value);
      },
    );
  }
}

EventList<ScheduleModel> listToEventList(List<ScheduleModel> list) {
  var events =
      EventList<ScheduleModel>(events: Map<DateTime, List<ScheduleModel>>());
  for (var item in list) {
    events.add(
        DateTime(item.getDate().year, item.getDate().month, item.getDate().day),
        item);
  }
  return events;
}
