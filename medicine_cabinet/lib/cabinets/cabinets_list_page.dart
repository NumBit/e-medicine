import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';

import 'cabinet_card.dart';
import 'create_cabinet_dialog.dart';

class CabinetsListPage extends StatelessWidget {
  const CabinetsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final streamBuilder = StreamBuilder<List<UserCabinetModel>>(
        stream: UserCabinetRepository().getMyCabinets(),
        initialData: const [],
        builder: (context, cabinets) {
          if (cabinets.data == null) return ListView();
          return ListView(
              children: cabinets.data!
                  .map((cab) => CabinetCard(
                        model: cab,
                      ))
                  .toList());
        });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('My Cabinets')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createCabinet(context);
          },
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add cabinet',
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      body: streamBuilder,
    );
  }
}

Future<void> createCabinet(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return CreateCabinetDialog(
            formKey: formKey, nameController: nameController);
      });
}
