import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/add_edit/selected_icon.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/main/cabinet_id.dart';

class AddDrug extends StatelessWidget {
  const AddDrug({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final substanceController = TextEditingController();
    final descriptionController = TextEditingController();
    SelectedIcon icon = Get.put(SelectedIcon());
    return Container(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Add new drug"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  NameField(nameController: nameController),
                  SubstanceField(substanceController: substanceController),
                  DescriptionField(
                      descriptionController: descriptionController),
                  IconField(icon: icon),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var drug = DrugModel(
                          name: nameController.text,
                          latinName: substanceController.text,
                          description: descriptionController.text,
                          icon: jsonEncode(iconDataToMap(icon.icon.value)),
                        );
                        CabinetId cabId = Get.find();
                        DrugRepository(context, cabId.id.value).add(drug);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Create"),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class IconField extends StatelessWidget {
  const IconField({
    Key key,
    @required this.icon,
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
                        iconColor: Theme.of(context).primaryColorDark)
                    .then((value) => icon.icon.value = value);
              },
              child: Text("Pick icon")),
        ],
      ),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    Key key,
    @required this.descriptionController,
  }) : super(key: key);

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: 2000,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: 'Description',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          border: OutlineInputBorder(),
        ),
        controller: descriptionController,
      ),
    );
  }
}

class SubstanceField extends StatelessWidget {
  const SubstanceField({
    Key key,
    @required this.substanceController,
  }) : super(key: key);

  final TextEditingController substanceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: 60,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          labelText: 'Active substance',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          border: OutlineInputBorder(),
        ),
        controller: substanceController,
      ),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    Key key,
    @required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: 40,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          border: OutlineInputBorder(),
          helperText: 'Required',
        ),
        controller: nameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
