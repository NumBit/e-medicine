import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/main/cabinet_id.dart';

class EditDrug extends StatelessWidget {
  const EditDrug({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrugModel model =
        ModalRoute.of(context).settings.arguments as DrugModel;
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: model.name);
    final substanceController = TextEditingController(text: model.latinName);
    final descriptionController =
        TextEditingController(text: model.description);
    var icon = Icons.ac_unit;
    CabinetId cabId = Get.find();
    return Container(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Edit drug"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
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
                  ),
                  Padding(
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
                  ),
                  Padding(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icon,
                          size: 40,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        TextButton(
                            onPressed: () {
                              FlutterIconPicker.showIconPicker(context,
                                      iconColor:
                                          Theme.of(context).primaryColorDark)
                                  .then((value) => icon = value);
                            },
                            child: Text("Pick icon")),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (Route<dynamic> route) => false);
                            DrugRepository(context, cabId.id.value)
                                .remove(model.id);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          child: Text("Delete")),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              var drug = DrugModel(
                                id: model.id,
                                name: nameController.text,
                                latinName: substanceController.text,
                                description: descriptionController.text,
                                icon: jsonEncode(iconDataToMap(icon)),
                              );
                              DrugRepository(context, cabId.id.value)
                                  .update(drug);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Save")),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
