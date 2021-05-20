import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/drug/add_edit/icon_field.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/data/selected_icon.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class AddDrug extends StatelessWidget {
  const AddDrug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final substanceController = TextEditingController();
    final descriptionController = TextEditingController();
    SelectedIcon icon = Get.put(SelectedIcon());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add new drug"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomFormField(
                    controller: nameController,
                    label: "Name",
                    helper: "Required",
                    maxLength: 40,
                    validator: (String? value) {
                      if (value == null || value.isBlank!)
                        return 'Name cannot be empty';
                      return null;
                    }),
                CustomFormField(
                    controller: substanceController,
                    label: "Active substance",
                    maxLength: 45),
                CustomFormField(
                  controller: descriptionController,
                  label: "Description",
                  minLines: 1,
                  maxLines: 8,
                  maxLength: 2000,
                ),
                IconField(icon: icon),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      NavigationState nav = Get.find();
                      UserState userState = Get.find();
                      var drug = DrugModel(
                        cabinetId: userState.openCabinetId.value,
                        name: nameController.text,
                        substance: substanceController.text,
                        description: descriptionController.text,
                        createdAt: Timestamp.now(),
                        icon: jsonEncode(serializeIcon(icon.icon.value!)),
                      );
                      DrugRepository(userState.openCabinetId.value).add(drug);
                      Get.back(id: nav.navigatorId.value);
                    }
                  },
                  child: Text("Create"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
