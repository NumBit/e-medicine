import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_cabinet/drug/add_edit/custom_form_field.dart';
import 'package:medicine_cabinet/firebase/storage/storage.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class EditProfile extends StatelessWidget {
  final String? name;
  const EditProfile({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final formKey = GlobalKey<FormState>();
    return SimpleDialog(
      title: const Text("Edit profile"),
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
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    }),
                ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        final UserState user = Get.find();
                        Get.back();
                        await Storage()
                            .uploadFile(pickedFile.path, pickedFile.path);
                        UserRepository().update(UserModel(
                            id: user.id.value,
                            profilePicture: pickedFile.path));
                      }
                      Get.back();
                    },
                    child: const Text("Pick user photo")),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final UserState user = Get.find();
                        user.name.value = nameController.text;
                        UserRepository().update(UserModel(
                            name: nameController.text, id: user.id.value));
                        Get.back();
                      }
                    },
                    child: const Text("Save")),
              ],
            )),
      ],
    );
  }
}
