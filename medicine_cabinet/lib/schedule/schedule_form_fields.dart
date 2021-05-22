import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';
import 'package:medicine_cabinet/schedule/data/time_picker_field.dart';
import 'package:medicine_cabinet/schedule/repeating.dart';

class TimePickers extends StatelessWidget {
  const TimePickers({
    Key? key,
    required this.startTime,
    required this.repeat,
    required this.endTime,
  }) : super(key: key);

  final Rx<TimeOfDay> startTime;
  final RxString repeat;
  final Rx<TimeOfDay> endTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: StartTimeField(startTime: startTime),
        ),
        Obx(() {
          if (repeat.value != Repeating.XHours) return Container();
          return Flexible(
            child: EndTimeField(endTime: endTime, startTime: startTime),
          );
        }),
      ],
    );
  }
}

class EndTimeField extends StatelessWidget {
  const EndTimeField({
    Key? key,
    required this.endTime,
    required this.startTime,
  }) : super(key: key);

  final Rx<TimeOfDay> endTime;
  final Rx<TimeOfDay> startTime;

  @override
  Widget build(BuildContext context) {
    return TimePickerField(
        label: "Last time",
        time: endTime,
        validator: (value) {
          if (toDouble(endTime.value) < toDouble(startTime.value))
            return "End time must be after start time";
          return null;
        });
  }
}

class StartTimeField extends StatelessWidget {
  const StartTimeField({
    Key? key,
    required this.startTime,
  }) : super(key: key);

  final Rx<TimeOfDay> startTime;

  @override
  Widget build(BuildContext context) {
    return TimePickerField(
      label: "Time",
      time: startTime,
    );
  }
}

class DatePickers extends StatelessWidget {
  const DatePickers({
    Key? key,
    required this.repeat,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  final RxString repeat;
  final Rx<DateTime> startDate;
  final Rx<DateTime> endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: StartDateField(
            date: startDate,
          ),
        ),
        Obx(() {
          if (repeat.value == Repeating.Never) return Container();
          return Flexible(
            child: EndDateField(endDate: endDate, startDate: startDate.value),
          );
        }),
      ],
    );
  }
}

class EndDateField extends StatelessWidget {
  const EndDateField({
    Key? key,
    required this.endDate,
    required this.startDate,
  }) : super(key: key);

  final Rx<DateTime> endDate;
  final DateTime startDate;

  @override
  Widget build(BuildContext context) {
    return DatePickerField(
      date: endDate,
      label: "End Day",
      validator: (value) {
        if (endDate.value.isBefore(startDate))
          return "End date must be after start date";
        return null;
      },
    );
  }
}

class StartDateField extends StatelessWidget {
  const StartDateField({
    Key? key,
    required this.date,
  }) : super(key: key);

  final Rx<DateTime> date;

  @override
  Widget build(BuildContext context) {
    return DatePickerField(
      date: date,
      label: "Starting Day",
    );
  }
}

class RepeatSelection extends StatelessWidget {
  const RepeatSelection({
    Key? key,
    required this.repeat,
  }) : super(key: key);

  final RxString repeat;

  @override
  Widget build(BuildContext context) {
    var repeatController = TextEditingController(text: repeat.value);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
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

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
