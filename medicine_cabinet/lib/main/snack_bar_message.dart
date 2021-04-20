import 'package:flutter/material.dart';

void snackBarMessage(context, String message, {int timeout = 3}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: timeout),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
