import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_model.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_repository.dart';
import 'package:medicine_cabinet/schedule/data/time_picker_field.dart';
import 'package:uuid/uuid.dart';

class EditSchedulePlan extends StatelessWidget {
  final String schedulerId;
  final DateTime date;
  const EditSchedulePlan({Key key, this.date, this.schedulerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final drugNameController = TextEditingController();
    final dosageController = TextEditingController(text: "");
    final countController = TextEditingController();
    final repeatController = TextEditingController();
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

    var repeat = "Never".obs;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit schedule"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: StreamBuilder<SchedulerModel>(
              stream: SchedulerRepository().streamModel(schedulerId),
              builder: (context, scheduler) {
                if (!scheduler.hasData) return LoadingWidget();
                drugNameController.text = scheduler.data.name;
                dosageController.text = scheduler.data.dosage;
                countController.text = scheduler.data.count.toString();
                repeatController.text = scheduler.data.repeatTimes.toString();
                repeat.value = scheduler.data.repeatType;
                startTime = scheduler.data.timeFrom;
                endTime = scheduler.data.timeTo;
                startDate = scheduler.data.dayFrom.toDate();
                endDate = scheduler.data.dayTo.toDate();
                startTimeController.text = MaterialLocalizations.of(context)
                    .formatTimeOfDay(startTime);
                endTimeController.text =
                    MaterialLocalizations.of(context).formatTimeOfDay(endTime);
                startDateController.text =
                    DateFormat("dd.MM.yyyy").format(startDate);
                endDateController.text =
                    DateFormat("dd.MM.yyyy").format(startDate);

                return Column(
                  children: [
                    CustomFormField(
                      label: "Drug",
                      controller: drugNameController,
                      validator: (String value) {
                        if (value == null || value.isBlank)
                          return "Drug cannot be empty";
                        return null;
                      },
                    ),
                    CustomFormField(
                      label: "Dosage",
                      controller: dosageController,
                    ),
                    CustomFormField(
                      label: "Count",
                      controller: countController,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (!GetUtils.isNum(value)) return "Must input number";
                        return null;
                      },
                    ),
                    Divider(
                      indent: 8,
                      endIndent: 8,
                      thickness: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: DropdownButtonFormField<String>(
                              value: repeat.value,
                              onChanged: (value) => repeat.value = value,
                              items: <String>[
                                "Never",
                                "X hours",
                                "Day",
                                "X days",
                                "Week"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                  labelText: "Repeat every",
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Obx(() {
                          if (repeat.value != "X hours" &&
                              repeat.value != "X days") return Container();
                          return Expanded(
                            child: CustomFormField(
                              label: "X",
                              controller: repeatController,
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (!GetUtils.isNum(value))
                                  return "Must input number";
                                return null;
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DatePickerField(
                      controller: startDateController,
                      label: "Starting Day",
                      onTap: (value) {
                        if (value != null) {
                          startDate = value;
                          startDateController.text =
                              DateFormat("dd.MM.yyyy").format(value);
                        }
                      },
                    ),
                    Obx(() {
                      if (repeat.value == "Never") return Container();
                      return DatePickerField(
                        controller: endDateController,
                        label: "End Day",
                        onTap: (value) {
                          if (value != null) {
                            endDate = value;
                            endDateController.text =
                                DateFormat("dd.MM.yyyy").format(value);
                          }
                        },
                        validator: (value) {
                          if (endDate.isBefore(startDate))
                            return "End date must be after start date";
                          return null;
                        },
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    TimePickerField(
                      controller: startTimeController,
                      label: "Time",
                      time: startTime,
                      onTap: (value) {
                        if (value != null) {
                          startTime = value;
                          startTimeController.text =
                              MaterialLocalizations.of(context)
                                  .formatTimeOfDay(value);
                        }
                      },
                    ),
                    Obx(() {
                      if (repeat.value != "X hours") return Container();
                      return TimePickerField(
                          controller: endTimeController,
                          label: "Last time",
                          time: endTime,
                          onTap: (value) {
                            if (value != null) {
                              endTime = value;
                              endTimeController.text =
                                  MaterialLocalizations.of(context)
                                      .formatTimeOfDay(value);
                            }
                          },
                          validator: (value) {
                            if (toDouble(endTime) < toDouble(startTime))
                              return "End time must be after start time";
                            return null;
                          });
                    }),
                    ElevatedButton(
                        onPressed: () {
                          editSchedules(
                              _formKey,
                              repeat,
                              drugNameController,
                              countController,
                              dosageController,
                              repeatController,
                              startDate,
                              endDate,
                              startTime,
                              endTime,
                              scheduler.data.schedulerKey);
                        },
                        child: Text("Edit")),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void editSchedules(
      GlobalKey<FormState> _formKey,
      RxString repeat,
      TextEditingController drugNameController,
      TextEditingController countController,
      TextEditingController dosageController,
      TextEditingController repeatController,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay startTime,
      TimeOfDay endTime,
      String oldSchedulerKey) async {
    if (_formKey.currentState.validate()) {
      NavigationState nav = Get.find();
      var schedulerKey = Uuid().v4();
      var scheduleRepo = ScheduleRepository();

      scheduleRepo.deleteAll(oldSchedulerKey);
      SchedulerRepository().update(SchedulerModel(
          id: schedulerId,
          schedulerKey: schedulerKey,
          name: drugNameController.text,
          dosage: dosageController.text,
          count: int.parse(countController.text),
          dayFrom: Timestamp.fromDate(startDate),
          dayTo: Timestamp.fromDate(endDate),
          timeFrom: startTime,
          timeTo: endTime));

      if (repeat.value == "Never") {
        scheduleRepo.add(ScheduleModel(
            schedulerId: schedulerId,
            schedulerKey: schedulerKey,
            name: drugNameController.text,
            count: int.parse(countController.text),
            timestamp: Timestamp.fromDate(DateTime(
                startDate.year,
                startDate.month,
                startDate.day,
                startTime.hour,
                startTime.minute)),
            dosage: dosageController.text));
      } else if (repeat.value == "Day") {
        var start = startDate;
        while (!start.isAfter(endDate)) {
          scheduleRepo.add(ScheduleModel(
              schedulerId: schedulerId,
              schedulerKey: schedulerKey,
              name: drugNameController.text,
              count: int.parse(countController.text),
              timestamp: Timestamp.fromDate(DateTime(start.year, start.month,
                  start.day, startTime.hour, startTime.minute)),
              dosage: dosageController.text));
          start = start.add(Duration(days: 1));
        }
      } else if (repeat.value == "Week") {
        var start = startDate;
        while (!start.isAfter(endDate)) {
          scheduleRepo.add(ScheduleModel(
              schedulerId: schedulerId,
              schedulerKey: schedulerKey,
              name: drugNameController.text,
              count: int.parse(countController.text),
              timestamp: Timestamp.fromDate(DateTime(start.year, start.month,
                  start.day, startTime.hour, startTime.minute)),
              dosage: dosageController.text));
          start = start.add(Duration(days: 7));
        }
      } else if (repeat.value == "Day") {
        var start = startDate;
        while (!start.isAfter(endDate)) {
          scheduleRepo.add(ScheduleModel(
              schedulerId: schedulerId,
              schedulerKey: schedulerKey,
              name: drugNameController.text,
              count: int.parse(countController.text),
              timestamp: Timestamp.fromDate(DateTime(start.year, start.month,
                  start.day, startTime.hour, startTime.minute)),
              dosage: dosageController.text));
          start = start.add(Duration(days: 1));
        }
      } else if (repeat.value == "X Days") {
        var start = startDate;
        while (!start.isAfter(endDate)) {
          scheduleRepo.add(ScheduleModel(
              schedulerId: schedulerId,
              schedulerKey: schedulerKey,
              name: drugNameController.text,
              count: int.parse(countController.text),
              timestamp: Timestamp.fromDate(DateTime(start.year, start.month,
                  start.day, startTime.hour, startTime.minute)),
              dosage: dosageController.text));
          start = start.add(Duration(days: int.parse(repeatController.text)));
        }
      } else if (repeat.value == "X hours") {
        var start = startDate;
        while (!start.isAfter(endDate)) {
          var startTimeTmp = startTime;
          print(start.day);
          print("s" + startTimeTmp.hour.toString());
          print("e" + endTime.hour.toString());
          while (toDouble(startTimeTmp) <= toDouble(endTime)) {
            print(startTimeTmp.hour);
            scheduleRepo.add(ScheduleModel(
                schedulerId: schedulerId,
                schedulerKey: schedulerKey,
                name: drugNameController.text,
                count: int.parse(countController.text),
                timestamp: Timestamp.fromDate(DateTime(start.year, start.month,
                    start.day, startTimeTmp.hour, startTimeTmp.minute)),
                dosage: dosageController.text));
            if (startTimeTmp.hour + int.parse(repeatController.text) > 24)
              startTimeTmp = startTimeTmp.replacing(hour: 23, minute: 59);
            else
              startTimeTmp = startTimeTmp.replacing(
                  hour: startTimeTmp.hour + int.parse(repeatController.text));
          }
          start = start.add(Duration(days: 1));
        }
      }
      Get.back(id: nav.navigatorId.value);
    }
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
