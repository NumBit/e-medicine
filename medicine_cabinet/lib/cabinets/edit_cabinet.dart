import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';

class EditCabinet extends StatelessWidget {
  final CabinetModel model;
  const EditCabinet({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    nameController.text = model.name;
    return Container(
      child: SimpleDialog(
        title: Text("Edit Cabinet"),
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                        onChanged: (value) {
                          _formKey.currentState.validate();
                        },
                        maxLength: 40,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                          border: OutlineInputBorder(),
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
                        onPressed: () {
                          Navigator.pop(context);
                          CabinetRepository(context).remove(model.id);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).errorColor),
                        child: Text("Delete"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            CabinetRepository(context).update(CabinetModel(
                                id: model.id, name: nameController.text));
                            Navigator.pop(context);
                          },
                          child: Text("Save")),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
