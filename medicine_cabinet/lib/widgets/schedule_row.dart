import 'package:flutter/material.dart';

class ScheduleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          width: 100,
          child: Row(
            children: [
              Column(
                children: [Text("123"), Text("456")],
              ),
              Column(
                children: [Center(child: Text("abc"))],
              ),
            ],
          )),
    );
  }
}
