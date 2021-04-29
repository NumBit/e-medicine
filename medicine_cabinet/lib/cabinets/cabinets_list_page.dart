import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_repository.dart';

import 'cabinet_card.dart';
import 'create_cabinet_dialog.dart';

class CabinetsListPage extends StatelessWidget {
  const CabinetsListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cabinets')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createCabinet(context);
          },
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add cabinet',
          child: Icon(
            Icons.add,
            size: 30,
          )),
      body: StreamBuilder<List<CabinetModel>>(
          stream: CabinetRepository(context).streamModels(),
          initialData: [],
          builder: (context, cabinets) {
            return ListView(
                children: cabinets.data
                    .map((cab) => CabinetCard(
                          model: cab,
                        ))
                    .toList());
          }),
    );
  }
}

Future<void> createCabinet(context) async {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return CreateCabinetDialog(
            formKey: _formKey, nameController: nameController);
      });
}
