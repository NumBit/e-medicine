import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/data/selected_date.dart';
import 'package:medicine_cabinet/schedule/schedule_item.dart';
import 'package:medicine_cabinet/schedule/week_calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = Get.put(SelectedDate());
    return Scaffold(
      appBar: _buildSchedulePageAppBar(context),
      floatingActionButton: const AddScheduleButton(),
      body: StreamBuilder<List<ScheduleModel>>(
          stream: ScheduleRepository().streamModels(),
          builder: (context, schedules) {
            if (!schedules.hasData) return const LoadingWidget();
            final events = schedules.data;
            return Column(
              children: [
                WeekCalendar(events: events),
                SchedulesList(events: events, date: date),
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

class SchedulesList extends StatelessWidget {
  const SchedulesList({
    Key? key,
    required this.events,
    required this.date,
  }) : super(key: key);

  final List<ScheduleModel>? events;
  final SelectedDate date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final selectedDay = date.date.value;
        final schedulesList = events!
            .where((element) =>
                getDateOnly(element.timestamp!.toDate()) == selectedDay)
            .map((e) => ScheduleItem(model: e))
            .toList();
        schedulesList
            .sort((a, b) => a.model.timestamp!.compareTo(b.model.timestamp!));
        return ListView(
          children: schedulesList,
        );
      }),
    );
  }
}

class AddScheduleButton extends StatelessWidget {
  const AddScheduleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        final NavigationState nav = Get.find();

        Get.toNamed("/create_schedule", id: nav.navigatorId.value);
      },
      child: const Icon(Icons.add),
    );
  }
}

DateTime getDateOnly(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
