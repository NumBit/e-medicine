import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/cabinet_model.dart';
import 'package:medicine_cabinet/cabinet/cabinet_repository.dart';
import 'package:medicine_cabinet/category/category_model.dart';
import 'package:medicine_cabinet/category/category_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class ExperimentPage extends StatelessWidget {
  const ExperimentPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiment'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          CabinetRepository(context).add("Constant Name");
        },
        label: const Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
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
              children: snapshot.data.docs.map((list) => list.data().map((doc) => CabinetModel.fromFirestore(doc)) {
                return Container(
                  child: Column(
                    children: [
                      Text(document.data()['name']),
                      ElevatedButton(
                          onPressed: () {
                            CategoryRepository(context, document.id)
                                .add("Experiment");
                          },
                          child: Text("Add category")),
                      ElevatedButton(
                          onPressed: () {
                            CategoryRepository(context, document.id).update(
                                "8gP8Qf6F4JPDLUjGSBS9", CategoryModel("Covid"));
                          },
                          child: Text("Delete me"))
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class ( {
}
