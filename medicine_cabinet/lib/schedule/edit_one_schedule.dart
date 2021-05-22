import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/notifications/notifications.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/schedule_form_fields.dart';

class EditOneSchedule extends StatelessWidget {
  final ScheduleModel model;
  const EditOneSchedule({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final drugNameController = TextEditingController(text: model.name);
    final dosageController = TextEditingController(text: model.dosage);
    final countController = TextEditingController(text: model.count.toString());
    var startTime = TimeOfDay(
      hour: model.timestamp!.toDate().hour,
      minute: model.timestamp!.toDate().minute,
    ).obs;
    var startDate = DateTime(
      model.timestamp!.toDate().year,
      model.timestamp!.toDate().month,
      model.timestamp!.toDate().day,
    ).obs;
    var notification = false.obs;
    if (model.notify != null) notification.value = model.notify!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit schedule"),
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
              StartTimeField(startTime: startTime),
              OptionDivider(),
              StartDateField(date: startDate),
              OptionDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScheduleRepository().delete(model.id);
                      Get.back(
                          id: Get.find<NavigationState>().navigatorId.value);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).errorColor),
                    child: Text("Delete"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        editSchedule(
                            formKey,
                            drugNameController,
                            countController,
                            dosageController,
                            startDate.value,
                            startTime.value,
                            model,
                            notification.value);
                      },
                      child: Text("Edit")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editSchedule(
      GlobalKey<FormState> formKey,
      TextEditingController drugNameController,
      TextEditingController countController,
      TextEditingController dosageController,
      DateTime startDate,
      TimeOfDay startTime,
      ScheduleModel model,
      bool notification) async {
    if (formKey.currentState!.validate()) {
      NavigationState nav = Get.find();
      var date = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      );
      if (model.notifyId != null) cancelNotification(model.notifyId!);
      var notificationId = await UserRepository().getNextNotifyId();
      if (notification)
        createNotification(
          notificationId,
          "Time to take ${countController.text}x ${drugNameController.text}.",
          date,
        );
      ScheduleRepository().update(ScheduleModel(
        id: model.id,
        name: drugNameController.text,
        count: int.parse(countController.text),
        timestamp: Timestamp.fromDate(date),
        dosage: dosageController.text,
        notify: notification,
        notifyId: notificationId,
      ));

      Get.back(id: nav.navigatorId.value);
    }
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
