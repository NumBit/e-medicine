import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/detail/date_picker_field.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';

class AddPackage extends StatelessWidget {
  final String drugId;
  const AddPackage({Key? key, required this.drugId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final dosageController = TextEditingController(text: "");
    final countController = TextEditingController();
    final expiration = DateTime.now().obs;
    return SimpleDialog(
      title: const Text("Add package"),
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomFormField(label: "Dosage", controller: dosageController),
                DatePickerField(
                  label: "Expiration",
                  date: expiration,
                ),
                CustomFormField(
                  label: "Count",
                  controller: countController,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || !GetUtils.isNum(value)) {
                      return "Must input number";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final model = PackageModel(
                            count: int.parse(countController.text),
                            dosage: dosageController.text,
                            drugId: drugId,
                            expiration: Timestamp.fromDate(expiration.value));
                        PackageRepository(drugId).add(model);
                        Get.back();
                      }
                    },
                    child: const Text("Add"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
