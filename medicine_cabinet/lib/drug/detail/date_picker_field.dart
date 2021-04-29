import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    Key key,
    @required this.controller,
    this.label,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final Function onTap;

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
              .then(onTap);
        },
        child: TextFormField(
          enabled: false,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
              labelText: "Expiration",
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColorDark,
              ),
              border: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey))),
          controller: controller,
        ),
      ),
    );
  }
}
