import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

import 'cabinet_model.dart';

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

  Stream getStream() {
    return collection.snapshots();
  }

  Future<void> add(CabinetModel model) {
    return collection
        .add(model.toJson())
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage(context, "Something went wrong"));
  }

  Future<void> update(CabinetModel model) {
    return collection
        .doc(model.id)
        .update(model.toJson())
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
