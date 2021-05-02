import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';

class AddPackage extends StatelessWidget {
  const AddPackage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dosageController = TextEditingController();
    final countController = TextEditingController();
    final timeController = TextEditingController(
        text: DateFormat('dd.MM.yyyy').format(DateTime.now()));
    var expiration = DateTime.now();
    return SimpleDialog(
      title: Text("Add package"),
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            child: Column(
              children: [
                CustomFormField(label: "Dosage", controller: dosageController),
                DatePickerField(
                    label: "Expiration",
                    controller: timeController,
                    onTap: (value) {
                      if (value != null) {
                        expiration = value;
                        timeController.text =
                            DateFormat('dd.MM.yyyy').format(value);
                      }
                    }),
                CustomFormField(
                    label: "Count",
                    controller: countController,
                    inputType: TextInputType.number),
                ElevatedButton(
                    onPressed: () {
                      print(expiration);
                    },
                    child: Text("Add"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
