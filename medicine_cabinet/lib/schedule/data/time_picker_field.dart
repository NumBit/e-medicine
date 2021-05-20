import 'dart:async';

import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    Key? key,
    required this.controller,
    this.label,
    this.onTap,
    this.time,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final Function? onTap;
  final TimeOfDay? time;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showTimePicker(
            initialEntryMode: TimePickerEntryMode.dial,
            initialTime: time!,
            context: context,
          ).then(onTap as FutureOr Function(TimeOfDay?));
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
