import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/collections.dart';
import 'package:medicine_cabinet/firebase/user_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class CabinetRepository extends Repository<CabinetModel> {
  CabinetRepository(BuildContext context)
      : super(
          context,
          FirebaseFirestore.instance.collection(Collections.cabinets),
        );

  @override
  Stream<CabinetModel> streamModel(String id) {
    return collection.snapshots().map((snap) => snap.docs
        .where((element) => element.id == id)
        .map((e) => CabinetModel.fromMap(e))
        .first);
  }

  @override
  Future<String> add(CabinetModel model) async {
    DocumentReference cabinet;
    try {
      cabinet = await collection.add(model.toJson());
      collection.doc(cabinet.id).collection(Collections.owners).add(
          {"user_id": FirebaseAuth.instance.currentUser.uid, "admin": true});
    } catch (error) {
      snackBarMessage(context, "Something went wrong");
    }
    print("Operation success.");
    return cabinet.id;
  }

  Stream<List<CabinetModel>> streamModels() {
    return collection.snapshots().map((snap) {
      return snap.docs.map((e) {
        return CabinetModel.fromMap(e);
      }).toList();
    });
  }

  Future<void> addOwner(String cabinetId, String newOwnerEmail) async {
    try {
      var newOwner =
          await UserRepository(context).getByEmail(newOwnerEmail).first;
      collection
          .doc(cabinetId)
          .collection(Collections.owners)
          .add({"user_id": newOwner.id});
    } catch (error) {
      snackBarMessage(context, "Something went wrong");
    }
    print("Operation success.");
  }
  /*
  Future<void> removeOwner(String cabinetId, String ownerId) async {
    try {
      var doc =
          await UserRepository(context).getByEmail(newOwnerEmail).first;
      collection
          .doc(cabinetId)
          .collection(Collections.owners)
          .add({"user_id": newOwner.id});
    } catch (error) {
      snackBarMessage(context, "Something went wrong");
    }
    print("Operation success.");
  }
  */
}
