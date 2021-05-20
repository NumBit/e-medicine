import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const LoginButton(
    this.text, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ),
          onPressed: onPressed as void Function()?),
    );
  }
}
