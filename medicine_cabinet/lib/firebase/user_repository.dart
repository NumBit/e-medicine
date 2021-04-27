import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/user_model.dart';

import 'collections.dart';

class UserRepository extends Repository<UserModel> {
  UserRepository(BuildContext context)
      : super(
          context,
          FirebaseFirestore.instance.collection(Collections.users),
        );

  @override
  Stream<UserModel> streamModel(String id) {
    return collection
        .snapshots()
        .map((snap) => snap.docs.map((e) => UserModel.fromMap(e)).first);
  }

  Stream<List<UserModel>> streamModels() {
    return collection.snapshots().map((snap) {
      return snap.docs.map((e) {
        return UserModel.fromMap(e);
      }).toList();
    });
  }

  Stream<UserModel> get(String id) {
    return collection
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(snap));
  }

  Stream<UserModel> getByEmail(String email) {
    return collection.where({"email": email}).snapshots().map((snap) {
          return snap.docs
              .map((e) {
                return UserModel.fromMap(e);
              })
              .toList()
              .first;
        });

    /*return collection
        .where({"email": email})
        .get()
        .then((value) => UserModel.fromMap(value))+
        .asStream()
        .map((snap) => UserModel.fromMap(snap.docs));*/
  }
}
