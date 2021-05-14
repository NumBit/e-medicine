import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinets/user_cabinet_tile.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';

class ShareCabinet extends StatelessWidget {
  final CabinetModel model;
  const ShareCabinet({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    return SimpleDialog(
      title: Center(child: Text("Current users")),
      children: [
        StreamBuilder<List<UserCabinetModel>>(
          stream: UserCabinetRepository().getCabinetUsers(model.id),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.data == null) return LoadingWidget();

            var emailCount = snapshot.data.length;
            return Container(
                height: emailCount < 3 ? 60 * emailCount.toDouble() : 180,
                width: 600,
                child: ListView(
                    children: snapshot.data
                        .map((e) => UserCabinetTile(model: e))
                        .toList()));
          },
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
                            !GetUtils.isEmail(value)) {
                          return 'Wrong email format';
                        }
                        return null;
                      }),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        UserCabinetRepository()
                            .addByEmail(emailController.text, model.id);
                        //emailController.text = "";
                      }
                    },
                    child: Text("Share")),
              ],
            )),
      ],
    );
  }
}
