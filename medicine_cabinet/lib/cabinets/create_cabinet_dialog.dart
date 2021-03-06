import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';

class CreateCabinetDialog extends StatelessWidget {
  const CreateCabinetDialog({
    Key? key,
    required this.formKey,
    required this.nameController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text("Create new medical cabinet"),
        children: [
          Form(
              key: formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                      onChanged: (value) {
                        formKey.currentState?.validate();
                      },
                      maxLength: 40,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      }),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState != null &&
                                formKey.currentState!.validate()) {
                              CabinetRepository().addToAuthUser(
                                  CabinetModel(name: nameController.text));
                              Get.back();
                            }
                          },
                          child: const Text("Save")),
                    ])
              ]))
        ]);
  }
}
