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
    if (id == null) return Stream.empty();
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
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.empty();
    }
    var myUid = user.uid;
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
        update(UserModel(openCabinetId: ""));
      });
    });
  }
}
