import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/drug/package/data/package_model.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';

class PackageCard extends StatelessWidget {
  final String drugId;
  final PackageModel model;
  const PackageCard({
    Key key,
    this.drugId,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        key: Key(model.id),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: Text(
                model.dossage,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              DateFormat('dd.MM.yyyy').format(model.expiration.toDate()),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (model.expiration.millisecondsSinceEpoch >
                        Timestamp.now().millisecondsSinceEpoch)
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).errorColor,
              ),
            ),
            SizedBox(
              width: 70,
              child: Text(
                model.count.toString() + " pcs",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  PackageRepository(drugId).increase(model);
                },
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).errorColor,
                  size: 50,
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  model.count.toString() + " pcs",
                  textScaleFactor: 1.8,
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  PackageRepository(drugId).decrease(model);
                },
                child: Icon(
                  Icons.remove,
                  color: Theme.of(context).primaryColorDark,
                  size: 50,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Get.dialog(DeletePackage(model: model));
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeletePackage extends StatelessWidget {
  const DeletePackage({
    Key key,
    @required this.model,
  }) : super(key: key);

  final PackageModel model;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Center(child: Text("Delete this package?")),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  onPressed: () => Get.back(),
                  child: Text("Cancel")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).errorColor),
                  onPressed: () {
                    PackageRepository(model.drugId).delete(model.id);
                    Get.back();
                  },
                  child: Text("Delete"))
            ],
          )
        ]);
  }
}
