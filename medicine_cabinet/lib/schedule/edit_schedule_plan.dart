import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/create_schedule.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_model.dart';
import 'package:medicine_cabinet/schedule/data/scheduler_repository.dart';
import 'package:medicine_cabinet/schedule/schedule_form_fields.dart';
import 'package:uuid/uuid.dart';

class EditSchedulePlan extends StatelessWidget {
  final String? schedulerId;
  final DateTime? date;
  const EditSchedulePlan({Key? key, this.date, this.schedulerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
          key: formKey,
          child: StreamBuilder<SchedulerModel>(
              stream: SchedulerRepository().streamModel(schedulerId),
              builder: (context, scheduler) {
                if (!scheduler.hasData) return LoadingWidget();
                drugNameController.text = scheduler.data!.name!;
                dosageController.text = scheduler.data!.dosage!;
                countController.text = scheduler.data!.count.toString();
                repeatController.text = scheduler.data!.repeatTimes.toString();
                repeat.value = scheduler.data!.repeatType!;
                startTime = scheduler.data!.timeFrom!;
                endTime = scheduler.data!.timeTo!;
                startDate = scheduler.data!.dayFrom!.toDate();
                endDate = scheduler.data!.dayTo!.toDate();
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
                    DrugNameField(drugNameController: drugNameController),
                    DosageField(dosageController: dosageController),
                    CountField(countController: countController),
                    Divider(
                      indent: 8,
                      endIndent: 8,
                      thickness: 3,
                    ),
                    RepeatSelection(
                        repeat: repeat, repeatController: repeatController),
                    SizedBox(height: 20),
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
                    SizedBox(
                      height: 20,
                    ),
                    TimePickers(
                      startTimeController: startTimeController,
                      startTime: startTime,
                      repeat: repeat,
                      endTimeController: endTimeController,
                      endTime: endTime,
                      setStartTime: (value) {
                        if (value != null) {
                          startTime = value;
                          startTimeController.text =
                              MaterialLocalizations.of(context)
                                  .formatTimeOfDay(value);
                        }
                      },
                      setEndTime: (value) {
                        if (value != null) {
                          endTime = value;
                          endTimeController.text =
                              MaterialLocalizations.of(context)
                                  .formatTimeOfDay(value);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ScheduleRepository()
                                .deleteAll(scheduler.data!.schedulerKey!);
                            Get.back(
                                id: Get.find<NavigationState>()
                                    .navigatorId
                                    .value);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          child: Text("Delete"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              editSchedules(
                                  formKey,
                                  repeat,
                                  drugNameController,
                                  countController,
                                  dosageController,
                                  repeatController,
                                  startDate,
                                  endDate,
                                  startTime,
                                  endTime,
                                  scheduler.data!.schedulerKey);
                            },
                            child: Text("Edit")),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void editSchedules(
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
      String? oldSchedulerKey) async {
    if (formKey.currentState!.validate()) {
      var repeatHours = int.parse(repeatController.text);
      var count = int.parse(countController.text);
      NavigationState nav = Get.find();
      var schedulerKey = Uuid().v4();
      var scheduleRepo = ScheduleRepository();
      scheduleRepo.deleteAll(oldSchedulerKey!);

      var scheduler = SchedulerModel(
          id: schedulerId,
          schedulerKey: schedulerKey,
          repeatTimes: repeatHours,
          repeatType: repeat.value,
          name: drugNameController.text,
          dosage: dosageController.text,
          count: int.parse(countController.text),
          dayFrom: Timestamp.fromDate(startDate),
          dayTo: Timestamp.fromDate(endDate),
          timeFrom: startTime,
          timeTo: endTime);
      SchedulerRepository().update(scheduler);
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
}
