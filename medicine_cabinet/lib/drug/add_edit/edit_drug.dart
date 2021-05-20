import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/data/selected_icon.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

import 'custom_form_field.dart';
import 'icon_field.dart';

class EditDrug extends StatelessWidget {
  final DrugModel model;
  const EditDrug({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final DrugModel model = Get.arguments as DrugModel;
    // print("-ARG: " + Get.arguments);
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: model.name);
    final substanceController = TextEditingController(text: model.substance);
    final descriptionController =
        TextEditingController(text: model.description);
    SelectedIcon icon = Get.put(SelectedIcon());
    icon.icon.value = deserializeIcon(jsonDecode(model.icon!));
    UserState userState = Get.find();
    return Container(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Edit drug"),
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
                        minLines: 2,
                        maxLines: 5,
                        maxLength: 2000),
                    IconField(icon: icon),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              NavigationState nav = Get.find();
                              print(Get.key.currentState!.bucket.toString());
                              Get.offNamedUntil("/", ModalRoute.withName("/"),
                                  id: nav.navigatorId.value);
                              DrugRepository(userState.openCabinetId.value)
                                  .delete(model.id);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).errorColor),
                            child: Text("Delete")),
                        ElevatedButton(
                            onPressed: () {
                              NavigationState nav = Get.find();

                              if (formKey.currentState!.validate()) {
                                var drug = DrugModel(
                                  id: model.id,
                                  name: nameController.text,
                                  substance: substanceController.text,
                                  description: descriptionController.text,
                                  icon: jsonEncode(
                                      serializeIcon(icon.icon.value!)),
                                );
                                DrugRepository(userState.openCabinetId.value)
                                    .update(drug);
                                Get.back(id: nav.navigatorId.value);
                              }
                            },
                            child: Text("Save")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
