import 'dart:async';

import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    Key? key,
    required this.controller,
    this.label,
    this.onTap,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final Function? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2500))
              .then(onTap as FutureOr Function(DateTime?));
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
