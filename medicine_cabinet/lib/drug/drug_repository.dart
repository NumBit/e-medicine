import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

import 'drug_model.dart';

class DrugRepository {
  CollectionReference collection;
  BuildContext context;

  DrugRepository(BuildContext context, String cabinetId) {
    this.context = context;
    this.collection = FirebaseFirestore.instance
        .collection("cabinets")
        .doc(cabinetId)
        .collection("drugs");
  }

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

  Future<void> update(String docId, DrugModel model) {
    return collection
        .doc(docId)
        .update({
          "name": model.name,
          "latin_name": model.latinName,
          "description": model.description,
          "icon": model.icon
        })
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
