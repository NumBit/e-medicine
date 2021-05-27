import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Description extends StatefulWidget {
  const Description({Key? key, this.description}) : super(key: key);
  final String? description;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: InkWell(
              onTap: () {
                Get.dialog(
                  DescriptionDialog(widget: widget),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.description!,
                    maxLines: 8,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Description widget;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Description"),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: 2000,
            child: Text(
              widget.description!,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
