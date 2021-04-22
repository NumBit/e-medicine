import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/cabinet_model.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class CabinetRepository {
  BuildContext context;

  CabinetRepository(BuildContext context) {
    this.context = context;
  }

  CollectionReference collection =
      FirebaseFirestore.instance.collection('cabinets');

  CollectionReference getCollection() {
    return collection;
  }

  Future<void> add(String name) {
    return collection
        .add({
          'name': name,
        })
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage(context, "Something went wrong"));
  }

  Future<void> update(String docId, CabinetModel model) {
    return collection
        .doc(docId)
        .update({"name": model.name})
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage(context, "Something went wrong"));
  }

  Future<void> remove(String docId) {
    return collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage(context, "Something went wrong"));
  }
}
