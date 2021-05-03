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

  Stream<UserModel> getMyUser() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    var myUid = user.uid;
    return collection
        .where("user_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => UserModel.fromMap(e)).toList().first;
      } else {
        return null;
      }
    });
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
  TODO sharing of cabinets
  Future<void> addCabinet(String cabinetId, String cabinetName) async {
    UserState docId = Get.find();
    collection
        .doc(docId.id.value)
        .collection(Collections.cabinets)
        .add(UserCabinetModel(cabinetId: cabinetId, name: cabinetName).toJson())
        .catchError((error) {
      print("Error occured when adding cabinet to user");
    });
  }*/
/*
  Future<void> removeCabinet(String cabinetId, String ownerId) async {
    try {
      UserDocId docId = Get.find();
      collection
          .doc(docId.id.value)
          .collection(Collections.cabinets)
          .doc(owner.id)
          .delete();
      snackBarMessage(context, "Share removed");
    } catch (error) {
      snackBarMessage(context, "Something went wrong");
    }
  }
  Future<bool> addCabinetByEmail(
      String userEmail, String cabinetId, String cabinetName) async {
    var user = await getByEmail(userEmail);
    if (user == null) {
      return false;
    }
    collection
        .doc(user.id)
        .collection(Collections.cabinets)
        .add(UserCabinetModel(cabinetId: cabinetId, name: cabinetName).toJson())
        .catchError((error) {});
    return true;
  }

  Stream<List<CabinetModel>> streamMyCabinets() {
    UserState docId = Get.find();
    return collection
        .doc(docId.id.value)
        .collection(Collections.cabinets)
        .snapshots()
        .map((snap) {
      return snap.docs.map((e) {
        return CabinetModel.fromMap(e);
      }).toList();
    });
  }*/
}
