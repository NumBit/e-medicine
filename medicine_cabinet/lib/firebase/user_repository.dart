import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/user_model.dart';

import 'collections.dart';

class UserRepository extends Repository<UserModel> {
  UserRepository(BuildContext context)
      : super(
          context,
          FirebaseFirestore.instance.collection(Collections.cabinetsCollection),
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
}
