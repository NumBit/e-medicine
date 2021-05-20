import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';

class ScheduleRepository extends Repository<ScheduleModel> {
  ScheduleRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.schedules),
        );

  @override
  Stream<ScheduleModel?> streamModel(String? id) {
    if (id == null) return Stream.empty();
    return collection.snapshots().map((snap) => snap.docs
        .where((element) => element.id == id)
        .map((e) => ScheduleModel.fromMap(
            e as QueryDocumentSnapshot<Map<String, dynamic>>))
        .first);
  }

  @override
  Future<String?> add(ScheduleModel model) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    DocumentReference cabinet;
    var item = ScheduleModel(
        ownerId: user.uid,
        schedulerId: model
            .schedulerId, // TODO WARNING, SET THIS IN FRONTEND (id from SchedulerRepo.Add)
        schedulerKey: model.schedulerKey,
        name: model.name,
        dosage: model.dosage,
        count: model.count,
        timestamp: model.timestamp,
        isTaken: model.isTaken ?? false);
    try {
      cabinet = await collection.add(item.toJson());
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
    }
    return cabinet.id;
  }

  Stream<List<ScheduleModel>> streamModels() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.empty();
    return collection
        .where("owner_id", isEqualTo: user.uid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => ScheduleModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      }
      return [];
    });
  }

  void deleteAll(String schedulerKey) {
    print("DELETE BY->" + schedulerKey);
    collection
        .where("scheduler_key", isEqualTo: schedulerKey)
        .snapshots()
        .forEach((snap) {
      snap.docs.forEach((e) {
        print("XY->");
        print(e.id);
        super.delete(e.id);
      });
    });
  }
}
