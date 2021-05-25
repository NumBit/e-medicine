import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    Key? key,
    this.label,
    required this.date,
    this.validator,
  }) : super(key: key);

  final Rx<DateTime> date;
  final String? label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(
        text: DateFormat("dd.MM.yyyy").format(date.value));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: date.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2500))
              .then((value) {
            if (value == null) return;
            controller.text = DateFormat("dd.MM.yyyy").format(value);
            date.value = value;
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
