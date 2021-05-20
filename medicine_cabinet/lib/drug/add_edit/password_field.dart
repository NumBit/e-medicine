import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
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
