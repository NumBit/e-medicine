import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';

class ShareCabinet extends StatelessWidget {
  final CabinetModel model;
  const ShareCabinet({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    var emailCount = 3;
    return SimpleDialog(
      title: Center(child: Text("Share Cabinet")),
      children: [
        Container(
          height: emailCount < 3 ? 60 * emailCount.toDouble() : 180,
          width: 600,
          child: ListView(
            children: [
              ListTile(
                title: Text("email@email.com"),
                trailing: Tooltip(
                  message: "Cancel sharing this cabinet",
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("email@email.com"),
                trailing: Tooltip(
                  message: "Cancel sharing this cabinet",
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("email@email.com"),
                trailing: Tooltip(
                  message: "Cancel sharing this cabinet",
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("email@email.com"),
                trailing: Tooltip(
                  message: "Cancel sharing this cabinet",
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(
                      inputType: TextInputType.emailAddress,
                      label: "Email",
                      controller: emailController,
                      validator: (String value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Wrong email format';
                        }
                        return null;
                      }),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Get.back();
                      }
                    },
                    child: Text("Share")),
              ],
            )),
      ],
    );
  }
}
