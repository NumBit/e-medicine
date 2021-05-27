import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/notifications/notifications.dart';
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
    var startTime = TimeOfDay.now().obs;
    var endTime = TimeOfDay.now().obs;
    var startDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).obs;
    var endDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).obs;

    var repeat = "Never".obs;
    var notification = false.obs;

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
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LoadingWidget();
                var scheduler = snapshot.data!;
                drugNameController.text = scheduler.name!;
                dosageController.text = scheduler.dosage!;
                countController.text = scheduler.count.toString();
                repeatController.text = scheduler.repeatTimes.toString();
                repeat.value = scheduler.repeatType!;
                startTime.value = scheduler.timeFrom!;
                endTime.value = scheduler.timeTo!;
                startDate.value = scheduler.dayFrom!.toDate();
                endDate.value = scheduler.dayTo!.toDate();
                if (scheduler.notify != null)
                  notification.value = scheduler.notify!;

                return Column(
                  children: [
                    SizedBox(height: 8),
                    DrugNameField(drugNameController: drugNameController),
                    DosageField(dosageController: dosageController),
                    CountField(countController: countController),
                    OptionDivider(),
                    NotificationOption(notification: notification),
                    OptionDivider(),
                    RepeatSelection(repeat: repeat),
                    OptionDivider(),
                    DatePickers(
                      repeat: repeat,
                      endDate: endDate,
                      startDate: startDate,
                    ),
                    OptionDivider(),
                    TimePickers(
                      startTime: startTime,
                      repeat: repeat,
                      endTime: endTime,
                    ),
                    OptionDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ScheduleRepository()
                                .deleteAll(scheduler.schedulerKey!);
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
                                startDate.value,
                                endDate.value,
                                startTime.value,
                                endTime.value,
                                scheduler.schedulerKey,
                                notification.value,
                              );
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
    String? oldSchedulerKey,
    bool notification,
  ) async {
    if (formKey.currentState!.validate()) {
      var repeatHours = int.parse(repeatController.text);
      var count = int.parse(countController.text);
      NavigationState nav = Get.find();
      var schedulerKey = Uuid().v4();
      var scheduleRepo = ScheduleRepository();
      var schedules = await scheduleRepo.listByKey(oldSchedulerKey);
      schedules.forEach((element) {
        if (element.notifyId != null) cancelNotification(element.notifyId!);
      });
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
        timeTo: endTime,
        notify: notification,
      );
      SchedulerRepository().update(scheduler);
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
          notification);
      Get.back(id: nav.navigatorId.value);
    }
  }
}
