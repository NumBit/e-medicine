import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    var startTime = TimeOfDay.now();
    final startTimeController = TextEditingController(
        text: MaterialLocalizations.of(context).formatTimeOfDay(startTime));
    var startDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final startDateController =
        TextEditingController(text: DateFormat("dd.MM.yyyy").format(startDate));
    var endTime = TimeOfDay.now();
    final endTimeController = TextEditingController(
        text: MaterialLocalizations.of(context).formatTimeOfDay(endTime));
    var endDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final endDateController =
        TextEditingController(text: DateFormat("dd.MM.yyyy").format(startDate));

    var repeat = Repeating.Never.obs;
    var notification = false.obs;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create schedule"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 8),
              DrugNameField(drugNameController: drugNameController),
              DosageField(dosageController: dosageController),
              CountField(countController: countController),
              OptionDivider(),
              NotificationOption(notification: notification),
              OptionDivider(),
              RepeatSelection(
                  repeat: repeat, repeatController: repeatController),
              OptionDivider(),
              DatePickers(
                startDateController: startDateController,
                repeat: repeat,
                endDateController: endDateController,
                endDate: endDate,
                startDate: startDate,
                setStartDate: (value) {
                  if (value != null) {
                    startDate = value;
                    startDateController.text =
                        DateFormat("dd.MM.yyyy").format(value);
                  }
                },
                setEndDate: (value) {
                  if (value != null) {
                    endDate = value;
                    endDateController.text =
                        DateFormat("dd.MM.yyyy").format(value);
                  }
                },
              ),
              OptionDivider(),
              TimePickers(
                startTimeController: startTimeController,
                startTime: startTime,
                repeat: repeat,
                endTimeController: endTimeController,
                endTime: endTime,
                setStartTime: (value) {
                  if (value != null) {
                    startTime = value;
                    startTimeController.text = MaterialLocalizations.of(context)
                        .formatTimeOfDay(value);
                  }
                },
                setEndTime: (value) {
                  if (value != null) {
                    endTime = value;
                    endTimeController.text = MaterialLocalizations.of(context)
                        .formatTimeOfDay(value);
                  }
                },
              ),
              OptionDivider(),
              ElevatedButton(
                  onPressed: () {
                    createSchedules(
                        formKey,
                        repeat,
                        drugNameController,
                        countController,
                        dosageController,
                        repeatController,
                        startDate,
                        endDate,
                        startTime,
                        endTime);
                  },
                  child: Text("Create")),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionDivider extends StatelessWidget {
  const OptionDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 8,
      endIndent: 8,
      thickness: 1,
    );
  }
}

class NotificationOption extends StatelessWidget {
  const NotificationOption({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final RxBool notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Enable notification",
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).primaryColorDark),
          ),
          Obx(() => Switch(
              value: notification.value,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                notification.value = value;
              }))
        ],
      ),
    );
  }
}

void createSchedules(
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
) async {
  if (formKey.currentState!.validate()) {
    var repeatHours = int.parse(repeatController.text);
    var count = int.parse(countController.text);
    NavigationState nav = Get.find();
    var schedulerKey = Uuid().v4();
    var scheduleRepo = ScheduleRepository();
    var schedulerId = await SchedulerRepository().add(SchedulerModel(
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
        scheduleRepo,
        schedulerId,
        schedulerKey,
        drugNameController,
        count,
        startDate,
        startTime,
        dosageController,
        endDate,
        repeatHours,
        endTime);
    Get.back(id: nav.navigatorId.value);
  }
}

void createRepeatingSchedules(
    RxString repeat,
    ScheduleRepository scheduleRepo,
    String? schedulerId,
    String schedulerKey,
    TextEditingController drugNameController,
    int count,
    DateTime startDate,
    TimeOfDay startTime,
    TextEditingController dosageController,
    DateTime endDate,
    int repeatHours,
    TimeOfDay endTime) {
  if (repeat.value == Repeating.Never) {
    createScheduleNoRepeat(
      scheduleRepo,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startDate,
      startTime,
      dosageController,
    );
  } else if (repeat.value == Repeating.Day) {
    createScheduleDayRepeat(
      startDate,
      endDate,
      scheduleRepo,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startTime,
      dosageController,
    );
  } else if (repeat.value == Repeating.Week) {
    createScheduleWeekRepeat(
      startDate,
      endDate,
      scheduleRepo,
      schedulerId,
      schedulerKey,
      drugNameController,
      count,
      startTime,
      dosageController,
    );
  } else if (repeat.value == Repeating.XDays) {
    createScheduleXDaysRepeat(
        startDate,
        endDate,
        scheduleRepo,
        schedulerId,
        schedulerKey,
        drugNameController,
        count,
        startTime,
        dosageController,
        repeatHours);
  } else if (repeat.value == Repeating.XHours) {
    createScheduleXHoursRepeat(
        startDate,
        endDate,
        startTime,
        endTime,
        scheduleRepo,
        schedulerId,
        schedulerKey,
        drugNameController,
        count,
        dosageController,
        repeatHours);
  }
}

void createScheduleXHoursRepeat(
    DateTime startDate,
    DateTime endDate,
    TimeOfDay startTime,
    TimeOfDay endTime,
    ScheduleRepository scheduleRepo,
    String? schedulerId,
    String schedulerKey,
    TextEditingController drugNameController,
    int count,
    TextEditingController dosageController,
    int repeatHours) {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    var startTimeTmp = startTime;
    while (toDouble(startTimeTmp) <= toDouble(endTime)) {
      scheduleRepo.add(ScheduleModel(
          schedulerId: schedulerId,
          schedulerKey: schedulerKey,
          name: drugNameController.text,
          dosage: dosageController.text,
          count: count,
          timestamp: Timestamp.fromDate(DateTime(
            start.year,
            start.month,
            start.day,
            startTimeTmp.hour,
            startTimeTmp.minute,
          ))));

      startTimeTmp = startTimeTmp.hour + repeatHours >= 24
          ? startTimeTmp.replacing(hour: 23, minute: 59)
          : startTimeTmp.replacing(hour: startTimeTmp.hour + repeatHours);
    }
    start = start.add(Duration(days: 1));
  }
}

void createScheduleXDaysRepeat(
    DateTime startDate,
    DateTime endDate,
    ScheduleRepository scheduleRepo,
    String? schedulerId,
    String schedulerKey,
    TextEditingController drugNameController,
    int count,
    TimeOfDay startTime,
    TextEditingController dosageController,
    int repeatHours) {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    scheduleRepo.add(ScheduleModel(
        schedulerId: schedulerId,
        schedulerKey: schedulerKey,
        name: drugNameController.text,
        count: count,
        timestamp: Timestamp.fromDate(DateTime(
          start.year,
          start.month,
          start.day,
          startTime.hour,
          startTime.minute,
        )),
        dosage: dosageController.text));
    start = start.add(Duration(days: repeatHours));
  }
}

void createScheduleWeekRepeat(
    DateTime startDate,
    DateTime endDate,
    ScheduleRepository scheduleRepo,
    String? schedulerId,
    String schedulerKey,
    TextEditingController drugNameController,
    int count,
    TimeOfDay startTime,
    TextEditingController dosageController) {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    scheduleRepo.add(ScheduleModel(
        schedulerId: schedulerId,
        schedulerKey: schedulerKey,
        name: drugNameController.text,
        count: count,
        timestamp: Timestamp.fromDate(DateTime(
          start.year,
          start.month,
          start.day,
          startTime.hour,
          startTime.minute,
        )),
        dosage: dosageController.text));
    start = start.add(Duration(days: 7));
  }
}

void createScheduleDayRepeat(
    DateTime startDate,
    DateTime endDate,
    ScheduleRepository scheduleRepo,
    String? schedulerId,
    String schedulerKey,
    TextEditingController drugNameController,
    int count,
    TimeOfDay startTime,
    TextEditingController dosageController) {
  var start = startDate;
  while (!start.isAfter(endDate)) {
    scheduleRepo.add(ScheduleModel(
        schedulerId: schedulerId,
        schedulerKey: schedulerKey,
        name: drugNameController.text,
        count: count,
        timestamp: Timestamp.fromDate(DateTime(
          start.year,
          start.month,
          start.day,
          startTime.hour,
          startTime.minute,
        )),
        dosage: dosageController.text));
    start = start.add(Duration(days: 1));
  }
}

void createScheduleNoRepeat(
  ScheduleRepository scheduleRepo,
  String? schedulerId,
  String schedulerKey,
  TextEditingController drugNameController,
  int count,
  DateTime startDate,
  TimeOfDay startTime,
  TextEditingController dosageController,
) {
  var date = DateTime(
    startDate.year,
    startDate.month,
    startDate.day,
    startTime.hour,
    startTime.minute,
  );
  createNotification(
      1, "Time to take ${count.toString()}x ${drugNameController.text}.", date);
  scheduleRepo.add(
    ScheduleModel(
        schedulerId: schedulerId,
        schedulerKey: schedulerKey,
        name: drugNameController.text,
        count: count,
        timestamp: Timestamp.fromDate(date),
        dosage: dosageController.text),
  );
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
