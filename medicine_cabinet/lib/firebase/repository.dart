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

  Future<void> add(T model) {
    return collection
        .add(model.toJson())
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage(context, "Something went wrong"));
  }

  Future<void> update(T model) {
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
