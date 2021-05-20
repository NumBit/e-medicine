import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.helper,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputType,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final String? helper;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: inputType,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColorDark,
              ),
              border: OutlineInputBorder()),
          controller: controller,
          validator: validator,
        ));
  }
}
