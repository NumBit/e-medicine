import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/cabinet_model.dart';
import 'package:medicine_cabinet/cabinets/cabinet_repository.dart';
import 'package:medicine_cabinet/category/category_model.dart';
import 'package:medicine_cabinet/category/category_repository.dart';

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
          CabinetRepository(context).add(CabinetModel(name: "Special Cab"));
        },
        label: const Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: CabinetRepository(context).getStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            /*if (snapshot.hasData) {
                cabinets = snapshot.data.docs
                    .map((doc) => CabinetModel.fromMap(doc, doc.id))
                    .toList();
            }*/
            return ListView(
              children: snapshot.data.docs
                  .map((doc) => CabinetModel.fromMap(doc))
                  .toList()
                  .map((CabinetModel item) {
                return Container(
                  child: Column(
                    children: [
                      Text(item.name),
                      ElevatedButton(
                          onPressed: () {
                            CategoryRepository(context, item.id)
                                .add(CategoryModel(name: "Special"));
                          },
                          child: Text("Add category")),
                      ElevatedButton(
                          onPressed: () {
                            CategoryRepository(context, item.id).update(
                                CategoryModel(
                                    id: "8gP8Qf6F4JPDLUjGSBS9", name: "Covid"));
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
