import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';

class AddPackage extends StatelessWidget {
  final String drugId;
  const AddPackage({Key key, @required this.drugId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final dosageController = TextEditingController(text: "");
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
            key: _formKey,
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
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (!GetUtils.isNum(value)) return "Must input number";
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var model = PackageModel(
                            count: int.parse(countController.text),
                            dossage: dosageController.text,
                            drugId: drugId,
                            expiration: Timestamp.fromDate(expiration));
                        PackageRepository(drugId).add(model);
                        Get.back();
                      }
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
