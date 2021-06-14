import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/user/user_model.dart';

import '../constants/collections.dart';

class UserRepository extends Repository<UserModel> {
  UserRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.users),
        );

  @override
  Stream<UserModel> streamModel(String? id) {
    if (id == null) return const Stream.empty();
    return collection.snapshots().map((snap) => snap.docs
        .map((e) =>
            UserModel.fromMap(e as QueryDocumentSnapshot<Map<String, dynamic>>))
        .first);
  }

  Stream<UserModel> get(String id) {
    return collection.doc(id).snapshots().map((snap) =>
        UserModel.fromMap(snap as QueryDocumentSnapshot<Map<String, dynamic>>));
  }

  Stream<UserModel?> getMyUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    final myUid = user.uid;
    return collection
        .where("user_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => UserModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList()
            .first;
      } else {
        return null;
      }
    });
  }

  Future<UserModel?> getMyUserModel() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    final myUid = user.uid;
    final res =
        await collection.where("user_id", isEqualTo: myUid).get().then((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => UserModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList()
            .first;
      } else {
        return null;
      }
    });
    return res;
  }

  /*
  Future<int> count() async {
    final count = await collection
        .where("drug_id", isEqualTo: drugId)
        .get()
        .then((value) => value.size);
    return count;
  }
*/
  Future<UserModel?> getByEmail(String email) {
    return collection.where("email", isEqualTo: email).get().then((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => UserModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList()
            .first;
      } else {
        return null;
      }
    }).catchError((error) => null);
  }

  void setEmptyCabinet(String cabinetId) {
    collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .forEach((snap) {
      snap.docs.forEach((e) {
        update(const UserModel(openCabinetId: ""));
      });
    });
  }

  Future<int> getNextNotifyId() async {
    final user = await getMyUser().first;
    if (user == null) return 0;
    int counter = user.notifyCounter ?? 0;
    final res = counter;
    counter++;
    if (counter == (2 ^ 32 - 2)) counter = 0;
    update(UserModel(id: user.id, notifyCounter: counter));
    return res;
  }
}
