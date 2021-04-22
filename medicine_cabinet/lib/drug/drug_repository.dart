import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/firebase/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';

import 'drug_model.dart';

class DrugRepository extends Repository<DrugModel> {
  DrugRepository(BuildContext context, String cabinetId)
      : super(
          context,
          FirebaseFirestore.instance
              .collection(Collections.cabinetsCollection)
              .doc(cabinetId)
              .collection(Collections.drugsCollection),
        );
}
