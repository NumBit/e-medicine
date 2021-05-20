import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';
import 'package:medicine_cabinet/schedule/data/time_picker_field.dart';
import 'package:medicine_cabinet/schedule/repeating.dart';

class TimePickers extends StatelessWidget {
  const TimePickers({
    Key? key,
    required this.startTimeController,
    required this.startTime,
    required this.repeat,
    required this.endTimeController,
    required this.endTime,
    required this.setStartTime,
    required this.setEndTime,
  }) : super(key: key);

  final TextEditingController startTimeController;
  final TimeOfDay startTime;
  final RxString repeat;
  final TextEditingController endTimeController;
  final TimeOfDay endTime;
  final Function setStartTime;
  final Function setEndTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StartTimeField(
            startTimeController: startTimeController,
            startTime: startTime,
            setStartTime: setStartTime),
        Obx(() {
          if (repeat.value != Repeating.XHours) return Container();
          return EndTimeField(
              endTimeController: endTimeController,
              endTime: endTime,
              setEndTime: setEndTime,
              startTime: startTime);
        }),
      ],
    );
  }
}

class EndTimeField extends StatelessWidget {
  const EndTimeField({
    Key? key,
    required this.endTimeController,
    required this.endTime,
    required this.setEndTime,
    required this.startTime,
  }) : super(key: key);

  final TextEditingController endTimeController;
  final TimeOfDay endTime;
  final Function setEndTime;
  final TimeOfDay startTime;

  @override
  Widget build(BuildContext context) {
    return TimePickerField(
        controller: endTimeController,
        label: "Last time",
        time: endTime,
        onTap: setEndTime,
        validator: (value) {
          if (toDouble(endTime) < toDouble(startTime))
            return "End time must be after start time";
          return null;
        });
  }
}

class StartTimeField extends StatelessWidget {
  const StartTimeField({
    Key? key,
    required this.startTimeController,
    required this.startTime,
    required this.setStartTime,
  }) : super(key: key);

  final TextEditingController startTimeController;
  final TimeOfDay startTime;
  final Function setStartTime;

  @override
  Widget build(BuildContext context) {
    return TimePickerField(
      controller: startTimeController,
      label: "Time",
      time: startTime,
      onTap: setStartTime,
    );
  }
}

class DatePickers extends StatelessWidget {
  const DatePickers({
    Key? key,
    required this.repeat,
    required this.startDateController,
    required this.endDateController,
    required this.startDate,
    required this.endDate,
    required this.setStartDate,
    required this.setEndDate,
  }) : super(key: key);

  final RxString repeat;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final DateTime startDate;
  final DateTime endDate;
  final Function setStartDate;
  final Function setEndDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StartDateField(
            startDateController: startDateController,
            setStartDate: setStartDate),
        Obx(() {
          if (repeat.value == Repeating.Never) return Container();
          return EndDateField(
              endDateController: endDateController,
              setEndDate: setEndDate,
              endDate: endDate,
              startDate: startDate);
        }),
      ],
    );
  }
}

class EndDateField extends StatelessWidget {
  const EndDateField({
    Key? key,
    required this.endDateController,
    required this.setEndDate,
    required this.endDate,
    required this.startDate,
  }) : super(key: key);

  final TextEditingController endDateController;
  final Function setEndDate;
  final DateTime endDate;
  final DateTime startDate;

  @override
  Widget build(BuildContext context) {
    return DatePickerField(
      controller: endDateController,
      label: "End Day",
      onTap: setEndDate,
      validator: (value) {
        if (endDate.isBefore(startDate))
          return "End date must be after start date";
        return null;
      },
    );
  }
}

class StartDateField extends StatelessWidget {
  const StartDateField({
    Key? key,
    required this.startDateController,
    required this.setStartDate,
  }) : super(key: key);

  final TextEditingController startDateController;
  final Function setStartDate;

  @override
  Widget build(BuildContext context) {
    return DatePickerField(
        controller: startDateController,
        label: "Starting Day",
        onTap: setStartDate);
  }
}

class RepeatSelection extends StatelessWidget {
  const RepeatSelection({
    Key? key,
    required this.repeat,
    required this.repeatController,
  }) : super(key: key);

  final RxString repeat;
  final TextEditingController repeatController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButtonFormField<String>(
              value: repeat.value,
              onChanged: (value) => repeat.value = value!,
              items: <String>[
                Repeating.Never,
                Repeating.XHours,
                Repeating.Day,
                Repeating.XDays,
                Repeating.Week
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
          if (repeat.value != Repeating.XHours &&
              repeat.value != Repeating.XDays) return Container();
          return Expanded(
            child: CustomFormField(
              label: "X",
              controller: repeatController,
              inputType: TextInputType.number,
              validator: (value) {
                if (value == null || !GetUtils.isNumericOnly(value))
                  return "Must input whole number";
                if (int.parse(value) == 0) return "Cannot select 0";
                return null;
              },
            ),
          );
        }),
      ],
    );
  }
}

class CountField extends StatelessWidget {
  const CountField({
    Key? key,
    required this.countController,
  }) : super(key: key);

  final TextEditingController countController;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      label: "Count",
      controller: countController,
      inputType: TextInputType.number,
      validator: (value) {
        if (value == null || !GetUtils.isNum(value)) return "Must input number";
        return null;
      },
    );
  }
}

class DosageField extends StatelessWidget {
  const DosageField({
    Key? key,
    required this.dosageController,
  }) : super(key: key);

  final TextEditingController dosageController;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      label: "Dosage",
      controller: dosageController,
    );
  }
}

class DrugNameField extends StatelessWidget {
  const DrugNameField({
    Key? key,
    required this.drugNameController,
  }) : super(key: key);

  final TextEditingController drugNameController;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      label: "Drug",
      controller: drugNameController,
      validator: (String? value) {
        if (value == null || value.isBlank!) return "Drug cannot be empty";
        return null;
      },
    );
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
