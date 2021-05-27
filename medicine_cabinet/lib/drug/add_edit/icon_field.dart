import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/selected_icon.dart';

class IconField extends StatelessWidget {
  const IconField({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final SelectedIcon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() => Icon(
                icon.icon.value,
                size: 40,
                color: Theme.of(context).primaryColorDark,
              )),
          TextButton(
              onPressed: () {
                FlutterIconPicker.showIconPicker(context,
                        iconPackMode: IconPack.fontAwesomeIcons,
                        iconColor: Theme.of(context).primaryColorDark)
                    .then((value) {
                  if (value != null) icon.icon.value = value;
                });
              },
              child: const Text("Pick icon")),
        ],
      ),
    );
  }
}
