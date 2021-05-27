import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class UserCabinetRepository extends Repository<UserCabinetModel> {
  UserCabinetRepository()
      : super(
          FirebaseFirestore.instance.collection(Collections.userCabinet),
        );

  @override
  Stream<UserCabinetModel> streamModel(String? id) {
    return collection.snapshots().map((snap) => snap.docs
        .map((e) => UserCabinetModel.fromMap(
            e as QueryDocumentSnapshot<Map<String, dynamic>>))
        .first);
  }

  Stream<List<UserCabinetModel>> getMyCabinets() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.empty();
    return collection
        .where("user_id", isEqualTo: user.uid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => UserCabinetModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      }
      return [];
    });
  }

  Stream<List<UserCabinetModel>> getCabinetUsers(String? cabinetId) {
    if (cabinetId == null) return Stream.empty();
    return collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs
            .map((e) => UserCabinetModel.fromMap(
                e as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      }
      return [];
    });
  }

  Future<bool> isCabinetUser(String? cabinetId, String? userId) async {
    if (cabinetId == null || userId == null) return false;
    var res = await collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .where("user_id", isEqualTo: userId)
        .get()
        .then((value) => value.docs.length);

    if (res == 0) return false;
    return true;
  }

  Future<bool> addByEmail(String? email, String? cabinetId) async {
    if (email == null || cabinetId == null) return false;
    var user = await UserRepository().getByEmail(email);
    if (user == null) {
      snackBarMessage("User not found", "Check email format");
      return false;
    }
    var isShared = await isCabinetUser(cabinetId, user.userId ?? "");
    print(isShared);
    if (isShared) {
      snackBarMessage("Already shared", email);
      return false;
    }
    add(UserCabinetModel(
        cabinetId: cabinetId,
        userId: user.userId,
        userEmail: user.email,
        admin: false));
    snackBarMessage("Share added", email);
    return true;
  }

  void deleteAll(String? cabinetId) {
    if (cabinetId == null) return null;
    collection
        .where("cabinet_id", isEqualTo: cabinetId)
        .snapshots()
        .forEach((snap) {
      snap.docs.forEach((e) {
        super.delete(e.id);
      });
    });
  }

  Future<UserCabinetModel?> get(String? docId) async {
    if (docId == null) return null;
    Future<UserCabinetModel?>? res =
        await collection.doc(docId).get().then((e) {
      if (e.data() == null) return null;
      print("Exists: " + e.exists.toString());
      UserCabinetModel.fromJson(e.data() as Map<String, dynamic>);
    });
    return res;
  }

  @override
  Future<void> delete(String? docId) async {
    if (docId == null) return;
    print("To get: " + docId.toString());
    var doc = await get(docId);
    collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
    var userRepo = UserRepository();
    userRepo.setEmptyCabinet(doc?.cabinetId ?? "");
  }
}
