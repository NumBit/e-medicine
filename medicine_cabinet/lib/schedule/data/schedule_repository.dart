import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';

class ScheduleRepository extends Repository<ScheduleModel> {
  ScheduleRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.cabinets),
        );

  @override
  Stream<ScheduleModel> streamModel(String id) {
    return collection.snapshots().map((snap) => snap.docs
        .where((element) => element.id == id)
        .map((e) => ScheduleModel.fromMap(e))
        .first);
  }

  @override
  Future<String> add(ScheduleModel model) async {
    DocumentReference cabinet;
    model = ScheduleModel(name: model.name);
    try {
      cabinet = await collection.add(model.toJson());
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
    }
    return cabinet.id;
  }

  @override
  void delete(String docId) {
    collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
    UserCabinetRepository().deleteAll(docId);
  }

  Stream<List<ScheduleModel>> streamModels() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return collection
        .where("owner_id", isEqualTo: user.uid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => ScheduleModel.fromMap(e)).toList();
      }
      return [];
    });
  }
}
