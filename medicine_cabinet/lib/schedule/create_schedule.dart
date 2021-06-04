import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/notifications/notifications.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_model.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_repository.dart';
import 'package:medicine_cabinet/schedule/repeating.dart';
import 'package:medicine_cabinet/schedule/schedule_form_fields.dart';
import 'package:uuid/uuid.dart';

class CreateSchedule extends StatelessWidget {
  const CreateSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final drugNameController = TextEditingController();
    final dosageController = TextEditingController(text: "");
    final countController = TextEditingController();
    final repeatController = TextEditingController(text: "0");
    final startTime = TimeOfDay.now().obs;
    final startDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).obs;
    final endTime = TimeOfDay.now().obs;
    final endDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).obs;

    final repeat = Repeating.never.obs;
    final notification = false.obs;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create schedule"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              DrugNameField(drugNameController: drugNameController),
              DosageField(dosageController: dosageController),
              CountField(countController: countController),
              const OptionDivider(),
              NotificationOption(notification: notification),
              const OptionDivider(),
              RepeatSelection(
                  repeat: repeat, repeatController: repeatController),
              const OptionDivider(),
              DatePickers(
                repeat: repeat,
                endDate: endDate,
                startDate: startDate,
              ),
              const OptionDivider(),
              TimePickers(
                startTime: startTime,
                repeat: repeat,
                endTime: endTime,
              ),
              const OptionDivider(),
              ElevatedButton(
                  onPressed: () {
                    createSchedules(
                      formKey,
                      repeat,
                      drugNameController,
                      countController,
                      dosageController,
                      repeatController,
                      startDate.value,
                      endDate.value,
                      startTime.value,
                      endTime.value,
                      notification.value,
                    );
                  },
                  child: const Text("Create")),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> createSchedules(
  GlobalKey<FormState> formKey,
  RxString repeat,
  TextEditingController drugNameController,
  TextEditingController countController,
  TextEditingController dosageController,
  TextEditingController repeatController,
  DateTime startDate,
  DateTime endDate,
  TimeOfDay startTime,
  TimeOfDay endTime,
  bool notification,
) async {
  if (formKey.currentState!.validate()) {
    final repeatHours = int.parse(repeatController.text);
    final count = int.parse(countController.text);
    final NavigationState nav = Get.find();
    final schedulerKey = const Uuid().v4();
    final schedulerId = await SchedulerRepository().add(SchedulerModel(
        schedulerKey: schedulerKey,
        name: drugNameController.text,
        dosage: dosageController.text,
        repeatTimes: repeatHours,
        repeatType: repeat.value,
        count: count,
        dayFrom: Timestamp.fromDate(startDate),
        dayTo: Timestamp.fromDate(endDate),
        timeFrom: startTime,
        timeTo: endTime));

    createRepeatingSchedules(
      repeat,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startDate,
      startTime,
      dosageController,
      endDate,
      repeatHours,
      endTime,
      notification,
    );
    Get.back(id: nav.navigatorId.value);
  }
}

void createRepeatingSchedules(
  RxString repeat,
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  DateTime startDate,
  TimeOfDay startTime,
  TextEditingController dosageController,
  DateTime endDate,
  int repeatHours,
  TimeOfDay endTime,
  bool notification,
) {
  if (repeat.value == Repeating.never) {
    createScheduleNoRepeat(
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startDate,
      startTime,
      dosageController,
      notification,
    );
  } else if (repeat.value == Repeating.day) {
    createScheduleDayRepeat(
      startDate,
      endDate,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startTime,
      dosageController,
      notification,
    );
  } else if (repeat.value == Repeating.week) {
    createScheduleWeekRepeat(
      startDate,
      endDate,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startTime,
      dosageController,
      notification,
    );
  } else if (repeat.value == Repeating.xDays) {
    createScheduleXDaysRepeat(
      startDate,
      endDate,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startTime,
      dosageController,
      repeatHours,
      notification,
    );
  } else if (repeat.value == Repeating.xHours) {
    createScheduleXHoursRepeat(
      startDate,
      endDate,
      startTime,
      endTime,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      dosageController,
      repeatHours,
      notification,
    );
  }
}

Future<void> createScheduleXHoursRepeat(
  DateTime startDate,
  DateTime endDate,
  TimeOfDay startTime,
  TimeOfDay endTime,
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  TextEditingController dosageController,
  int repeatHours,
  bool notification,
) async {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    var startTimeTmp = startTime;
    while (toDouble(startTimeTmp) <= toDouble(endTime)) {
      final date = DateTime(
        start.year,
        start.month,
        start.day,
        startTimeTmp.hour,
        startTimeTmp.minute,
      );
      final notificationId = await UserRepository().getNextNotifyId();
      if (notification) {
        createNotification(
          notificationId,
          "Time to take ${count.toString()}x ${drugNameController.text}.",
          date,
        );
      }
      ScheduleRepository().add(ScheduleModel(
        schedulerId: schedulerId,
        schedulerKey: schedulerKey,
        name: drugNameController.text,
        dosage: dosageController.text,
        count: count,
        timestamp: Timestamp.fromDate(date),
        notify: notification,
        notifyId: notificationId,
      ));

      startTimeTmp = startTimeTmp.hour + repeatHours >= 24
          ? startTimeTmp.replacing(hour: 23, minute: 59)
          : startTimeTmp.replacing(hour: startTimeTmp.hour + repeatHours);
    }
    start = start.add(const Duration(days: 1));
  }
}

Future<void> createScheduleXDaysRepeat(
  DateTime startDate,
  DateTime endDate,
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  TimeOfDay startTime,
  TextEditingController dosageController,
  int repeatHours,
  bool notification,
) async {
  var start = startDate;
  final date = DateTime(
    start.year,
    start.month,
    start.day,
    startTime.hour,
    startTime.minute,
  );
  final notificationId = await UserRepository().getNextNotifyId();
  if (notification) {
    createNotification(
      notificationId,
      "Time to take ${count.toString()}x ${drugNameController.text}.",
      date,
    );
  }
  while (!start.isAfter(endDate)) {
    ScheduleRepository().add(ScheduleModel(
      schedulerId: schedulerId,
      schedulerKey: schedulerKey,
      name: drugNameController.text,
      count: count,
      timestamp: Timestamp.fromDate(date),
      dosage: dosageController.text,
      notify: notification,
      notifyId: notificationId,
    ));
    start = start.add(Duration(days: repeatHours));
  }
}

Future<void> createScheduleWeekRepeat(
  DateTime startDate,
  DateTime endDate,
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  TimeOfDay startTime,
  TextEditingController dosageController,
  bool notification,
) async {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    final date = DateTime(
      start.year,
      start.month,
      start.day,
      startTime.hour,
      startTime.minute,
    );
    final notificationId = await UserRepository().getNextNotifyId();
    if (notification) {
      createNotification(
        notificationId,
        "Time to take ${count.toString()}x ${drugNameController.text}.",
        date,
      );
    }
    ScheduleRepository().add(ScheduleModel(
      schedulerId: schedulerId,
      schedulerKey: schedulerKey,
      name: drugNameController.text,
      count: count,
      timestamp: Timestamp.fromDate(date),
      dosage: dosageController.text,
      notify: notification,
      notifyId: notificationId,
    ));
    start = start.add(const Duration(days: 7));
  }
}

Future<void> createScheduleDayRepeat(
  DateTime startDate,
  DateTime endDate,
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  TimeOfDay startTime,
  TextEditingController dosageController,
  bool notification,
) async {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    final date = DateTime(
      start.year,
      start.month,
      start.day,
      startTime.hour,
      startTime.minute,
    );
    final notificationId = await UserRepository().getNextNotifyId();
    if (notification) {
      createNotification(
        notificationId,
        "Time to take ${count.toString()}x ${drugNameController.text}.",
        date,
      );
    }
    ScheduleRepository().add(ScheduleModel(
      schedulerId: schedulerId,
      schedulerKey: schedulerKey,
      name: drugNameController.text,
      count: count,
      timestamp: Timestamp.fromDate(date),
      dosage: dosageController.text,
      notify: notification,
      notifyId: notificationId,
    ));
    start = start.add(const Duration(days: 1));
  }
}

Future<void> createScheduleNoRepeat(
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  DateTime startDate,
  TimeOfDay startTime,
  TextEditingController dosageController,
  bool notification,
) async {
  final date = DateTime(
    startDate.year,
    startDate.month,
    startDate.day,
    startTime.hour,
    startTime.minute,
  );
  final notificationId = await UserRepository().getNextNotifyId();
  if (notification) {
    createNotification(
      notificationId,
      "Time to take ${count.toString()}x ${drugNameController.text}.",
      date,
    );
  }
  ScheduleRepository().add(
    ScheduleModel(
      schedulerId: schedulerId,
      schedulerKey: schedulerKey,
      name: drugNameController.text,
      count: count,
      timestamp: Timestamp.fromDate(date),
      dosage: dosageController.text,
      notify: notification,
      notifyId: notificationId,
    ),
  );
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
