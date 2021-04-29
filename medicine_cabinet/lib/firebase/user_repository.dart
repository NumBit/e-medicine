import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Stream<UserModel> get(String id) {
    return collection
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(snap));
  }

  Future<UserModel> getMyUser() {
    var myUid = FirebaseAuth.instance.currentUser.uid;
    return collection.where("id", isEqualTo: myUid).get().then((value) {
      if (value.size > 0) {
        return value.docs.map((e) => UserModel.fromMap(e)).toList().first;
      } else {
        return null;
      }
    }).catchError((error) => null);
  }

  Future<UserModel> getByEmail(String email) {
    return collection.where("email", isEqualTo: email).get().then((value) {
      if (value.size > 0) {
        return value.docs.map((e) => UserModel.fromMap(e)).toList().first;
      } else {
        return null;
      }
    }).catchError((error) => null);
  }
/*
    Future<void> addCabinet(String userId, String cabinetId, String cabinetName) {
    return collection.where("email", isEqualTo: email).get().then((value) {
      if (value.size > 0) {
        return value.docs.map((e) => UserModel.fromMap(e)).toList().first;
      } else {
        return null;
      }
    }).catchError((error) => null);
  }*/
}
