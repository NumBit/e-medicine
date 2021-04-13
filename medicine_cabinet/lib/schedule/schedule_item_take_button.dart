import 'package:flutter/material.dart';

class ScheduleItemTakeButton extends StatelessWidget {
  const ScheduleItemTakeButton({
    Key key,
    @required this.time,
    @required this.takeWhen,
  }) : super(key: key);

  final TimeOfDay time;
  final String takeWhen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        time.format(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        takeWhen,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle,
                    size: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
