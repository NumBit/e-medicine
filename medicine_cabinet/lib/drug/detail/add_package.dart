import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';

class AddPackage extends StatelessWidget {
  const AddPackage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dosageController = TextEditingController();
    final countController = TextEditingController();
    DateTime expiration;
    return SimpleDialog(
      title: Text("Add package"),
      children: [
        Form(
            child: Column(
          children: [
            CustomFormField(label: "Dosage", controller: dosageController),
            CustomFormField(
              label: "count",
              controller: countController,
              inputType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2500))
                      .then((value) => expiration = value);
                },
                child: Text("Expiration")),
            ElevatedButton(
                onPressed: () {
                  print(expiration);
                },
                child: Text("Add"))
          ],
        ))
      ],
    );
  }
}
