import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinets/cabinet_repository.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: CabinetRepository(context).getCollection().snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
                children: snapshot.data.docs
                    .map((DocumentSnapshot document) => CabinetCard(
                          name: document.data()['name'],
                          id: document.id,
                          isSelected: true,
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
