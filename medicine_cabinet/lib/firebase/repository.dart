import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/model.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

abstract class Repository<T extends Model> {
  BuildContext context;
  CollectionReference collection;

  Repository(BuildContext context, CollectionReference collection) {
    this.context = context;
    this.collection = collection;
  }

  CollectionReference getCollection() {
    return collection;
  }

  Stream<T> streamModel(String id);

  Stream getStream() {
    return collection.snapshots();
  }

  Future<String> add(T model) {
    return collection
        .add(model.toJson())
        .then((value) => value.id)
        .catchError((error) {
      snackBarMessage(context, "Something went wrong on add");
      return "";
    });
  }

  Future<void> update(T model) {
    return collection
        .doc(model.id)
        .update(model.toJson())
        .then((value) => print("Operation success."))
        .catchError((error) =>
            snackBarMessage(context, "Something went wrong on update"));
  }

  Future<void> delete(String docId) {
    return collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError((error) =>
            snackBarMessage(context, "Something went wrong on remove"));
  }
}
