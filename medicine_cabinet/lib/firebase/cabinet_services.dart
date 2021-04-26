import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinets/cabinet_repository.dart';
import 'package:medicine_cabinet/category/category_repository.dart';
import 'package:medicine_cabinet/drug/drug_repository.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/user_model.dart';
import 'package:medicine_cabinet/firebase/user_repository.dart';

import 'collections.dart';

class CabinetServices {
  CabinetServices(BuildContext context);

  CabinetRepository cabinetRep;
  UserRepository userRep;
  DrugRepository drugRep;
  CategoryRepository categoryRep;

  /*
  Stream<UserModel> getUser(String id) {
    return collection
        .snapshots()
        .map((snap) => snap.docs.map((e) => UserModel.fromMap(e)).first);
  }

  Stream<List<UserModel>> getUsers() {
    return collection.snapshots().map((snap) {
      return snap.docs.map((e) {
        return UserModel.fromMap(e);
      }).toList();
    });
  }*/
}
