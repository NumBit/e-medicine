import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/drug/drug_model.dart';
import 'package:medicine_cabinet/drug/drug_repository.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:provider/provider.dart';

class AddDrug extends StatelessWidget {
  const AddDrug({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final substanceController = TextEditingController();
    final descriptionController = TextEditingController();
    var icon = Icons.ac_unit;
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add new drug"),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Name"),
                TextFormField(
                    onChanged: (value) {
                      _formKey.currentState.validate();
                    },
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    }),
                Text("Active substance"),
                TextFormField(
                  onChanged: (value) {},
                  controller: substanceController,
                ),
                Text("Description"),
                TextFormField(
                  onChanged: (value) {},
                  controller: descriptionController,
                ),
                TextButton(
                    onPressed: () {
                      FlutterIconPicker.showIconPicker(context,
                              iconColor: Theme.of(context).primaryColorDark)
                          .then((value) => icon = value);
                    },
                    child: Text("Pick icon")),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var drug = DrugModel(
                          name: nameController.text,
                          latinName: substanceController.text,
                          description: descriptionController.text,
                          icon: jsonEncode(iconDataToMap(icon)),
                        );
                        DrugRepository(
                                context,
                                Provider.of<AppState>(context, listen: false)
                                    .cabinetId)
                            .add(drug);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Create"))
              ],
            ),
          )),
    );
  }
}
