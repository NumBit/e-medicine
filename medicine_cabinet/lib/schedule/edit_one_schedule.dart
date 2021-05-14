import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/data/schedule_repository.dart';
import 'package:medicine_cabinet/schedule/data/time_picker_field.dart';

class EditOneSchedule extends StatelessWidget {
  final ScheduleModel model;
  final DateTime date;
  const EditOneSchedule({Key key, this.date, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final drugNameController = TextEditingController(text: model.name);
    final dosageController = TextEditingController(text: model.dosage);
    final countController = TextEditingController(text: model.count.toString());
    var startTime = TimeOfDay(
        hour: model.timestamp.toDate().hour,
        minute: model.timestamp.toDate().minute);
    final startTimeController = TextEditingController(
        text: MaterialLocalizations.of(context).formatTimeOfDay(startTime));
    var startDate = DateTime(model.timestamp.toDate().year,
        model.timestamp.toDate().month, model.timestamp.toDate().day);
    final startDateController =
        TextEditingController(text: DateFormat("dd.MM.yyyy").format(startDate));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit schedule"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                    startTimeController.text = MaterialLocalizations.of(context)
                        .formatTimeOfDay(value);
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    createSchedules(
                        _formKey,
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
        ),
      ),
    );
  }

  void createSchedules(
    GlobalKey<FormState> _formKey,
    TextEditingController drugNameController,
    TextEditingController countController,
    TextEditingController dosageController,
    DateTime startDate,
    TimeOfDay startTime,
    ScheduleModel model,
  ) {
    if (_formKey.currentState.validate()) {
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
