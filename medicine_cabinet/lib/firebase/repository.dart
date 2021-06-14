import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/model.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

abstract class Repository<T extends Model> {
  final CollectionReference collection;

  Repository(this.collection);

  Stream<T?> streamModel(String? id);

  Future<String?> add(T model) {
    return collection
        .add(model.toJson())
        .then((value) => value.id)
        .catchError((error) {
      snackBarMessage("Operation ADD failed", "Nothing added");
      return "";
    });
  }

  void update(T model) {
    print("REPO UPDATE: model.getId() 9999999999999999999999999999999999");
    print(model.getId());
    collection
        .doc(model.getId())
        .update(model.toJson())
        .then((value) => debugPrint("Operation UPDATE success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing updated"));
  }

  void delete(String? docId) {
    collection
        .doc(docId)
        .delete()
        .then((value) => debugPrint("Operation DELETE success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
  }
}
