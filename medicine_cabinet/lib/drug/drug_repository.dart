import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/collections.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

import 'drug_model.dart';

class DrugRepository {
  CollectionReference collection;
  BuildContext context;

  DrugRepository(BuildContext context, String cabinetId) {
    this.context = context;
    this.collection = FirebaseFirestore.instance
        .collection(Collections.cabinetsCollection)
        .doc(cabinetId)
        .collection(Collections.drugsCollection);
  }

  CollectionReference getCollection() {
    return collection;
  }

  Future<void> add(DrugModel model) {
    return collection
        .add(model.toJson())
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage(context, "Something went wrong"));
  }

  Future<void> update(DrugModel model) {
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
