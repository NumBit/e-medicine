import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    Key? key,
    this.label,
    required this.time,
    this.validator,
  }) : super(key: key);

  final String? label;
  final Rx<TimeOfDay> time;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: time.value.format(context));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showTimePicker(
            initialEntryMode: TimePickerEntryMode.dial,
            initialTime: time.value,
            context: context,
          ).then((value) {
            if (value == null) return;
            time.value = value;
            controller.text = value.format(context);
          });
        },
        child: TextFormField(
          enabled: false,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            border: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey)),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: Theme.of(context).errorColor)),
            errorStyle: TextStyle(
              color: Theme.of(context).errorColor, // or any other color
            ),
          ),
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}
