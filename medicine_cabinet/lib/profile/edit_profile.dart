import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'package:medicine_cabinet/profile/profile_picture.dart';

class EditProfile extends StatelessWidget {
  final String? name;
  const EditProfile({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    final nameController = TextEditingController(text: name);
    final formKey = GlobalKey<FormState>();
    return Container(
      child: SimpleDialog(
        title: Text("Edit profile"),
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  CustomFormField(
                      label: "Name",
                      controller: nameController,
                      maxLength: 50,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Name cannot be empty";
                        return null;
                      }),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          UserState user = Get.find();
                          user.name.value = nameController.text;
                          UserRepository().update(UserModel(
                              name: nameController.text, id: user.id.value));
                          Get.back();
                        }
                      },
                      child: Text("Save")),
                  ElevatedButton(
                      onPressed: () async {
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          ProfilePicture pic = Get.find();
                          pic.imagePath.value = pickedFile.path;
                        }
                        Get.back();
                      },
                      child: Text("Pick user photo"))
                ],
              )),
        ],
      ),
    );
  }
}
