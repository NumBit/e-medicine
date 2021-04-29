import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/collections.dart';

import 'data/../category_model.dart';

class CategoryRepository extends Repository<CategoryModel> {
  CategoryRepository(BuildContext context, String cabinetId)
      : super(
          context,
          FirebaseFirestore.instance
              .collection(Collections.cabinets)
              .doc(cabinetId)
              .collection(Collections.categories),
        );

  @override
  Stream<CategoryModel> streamModel(String id) {
    // TODO: implement streamModel
    throw UnimplementedError();
  }
}
