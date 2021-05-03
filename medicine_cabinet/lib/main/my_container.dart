import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            TextButton(onPressed: () => Get.back(), child: Text("prev")),
            TextButton(
                onPressed: () => Get.to(MyContainer()), child: Text("next")),
          ],
        ),
        color: Colors.deepOrange,
      ),
    );
  }
}
