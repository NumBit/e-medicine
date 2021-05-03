import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/model.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

abstract class Repository<T extends Model> {
  CollectionReference collection;

  Repository(CollectionReference collection) {
    this.collection = collection;
  }

  Stream<T> streamModel(String id);

  Future<String> add(T model) {
    return collection
        .add(model.toJson())
        .then((value) => value.id)
        .catchError((error) {
      snackBarMessage("Operation failed", "Nothing added");
      return "";
    });
  }

  Future<void> update(T model) {
    return collection
        .doc(model.id)
        .update(model.toJson())
        .then((value) => print("Operation success."))
        .catchError((error) =>
            snackBarMessage("Operation failed", "Nothing updated"));
  }

  Future<void> delete(String docId) {
    return collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError((error) =>
            snackBarMessage("Operation failed", "Nothing removed"));
  }
}
