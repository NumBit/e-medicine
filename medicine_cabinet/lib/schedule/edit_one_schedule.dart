import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
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
        minute: model.timestamp!.toDate().minute);
    final startTimeController = TextEditingController(
        text: MaterialLocalizations.of(context).formatTimeOfDay(startTime));
    var startDate = DateTime(model.timestamp!.toDate().year,
        model.timestamp!.toDate().month, model.timestamp!.toDate().day);
    final startDateController =
        TextEditingController(text: DateFormat("dd.MM.yyyy").format(startDate));
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
              DrugNameField(drugNameController: drugNameController),
              DosageField(dosageController: dosageController),
              CountField(countController: countController),
              Divider(
                indent: 8,
                endIndent: 8,
                thickness: 3,
              ),
              StartTimeField(
                  startTimeController: startTimeController,
                  startTime: startTime,
                  setStartTime: (value) {
                    if (value != null) {
                      startTime = value;
                      startTimeController.text =
                          MaterialLocalizations.of(context)
                              .formatTimeOfDay(value);
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              StartDateField(
                startDateController: startDateController,
                setStartDate: (value) {
                  if (value != null) {
                    startDate = value;
                    startDateController.text =
                        DateFormat("dd.MM.yyyy").format(value);
                  }
                },
              ),
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
                        createSchedules(
                            formKey,
                            drugNameController,
                            countController,
                            dosageController,
                            startDate,
                            startTime,
                            model);
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

  void createSchedules(
    GlobalKey<FormState> formKey,
    TextEditingController drugNameController,
    TextEditingController countController,
    TextEditingController dosageController,
    DateTime startDate,
    TimeOfDay startTime,
    ScheduleModel model,
  ) {
    if (formKey.currentState!.validate()) {
      NavigationState nav = Get.find();
      ScheduleRepository().update(ScheduleModel(
          id: model.id,
          name: drugNameController.text,
          count: int.parse(countController.text),
          timestamp: Timestamp.fromDate(DateTime(
              startDate.year,
              startDate.month,
              startDate.day,
              startTime.hour,
              startTime.minute)),
          dosage: dosageController.text));

      Get.back(id: nav.navigatorId.value);
    }
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
