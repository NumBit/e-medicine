import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class CabinetRepository extends Repository<CabinetModel> {
  CabinetRepository(BuildContext context)
      : super(
          context,
          FirebaseFirestore.instance.collection(Collections.cabinets),
        );

  @override
  Stream<CabinetModel> streamModel(String id) {
    return collection.snapshots().map((snap) => snap.docs
        .where((element) => element.id == id)
        .map((e) => CabinetModel.fromMap(e))
        .first);
  }

  @override
  Future<String> add(CabinetModel model) async {
    DocumentReference cabinet;
    var ownerId = FirebaseAuth.instance.currentUser.uid;
    model = CabinetModel(name: model.name, ownerId: ownerId);
    try {
      cabinet = await collection.add(model.toJson());
    } catch (e) {
      snackBarMessage(context, "Something went wrong");
    }
    return cabinet.id;
  }

  Stream<List<CabinetModel>> streamModels() {
    var myUid = FirebaseAuth.instance.currentUser.uid;
    return collection
        .where("owner_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => CabinetModel.fromMap(e)).toList();
      }
      return [];
    });
  }

  Stream<int> cabinetCount() {
    var myUid = FirebaseAuth.instance.currentUser.uid;
    return collection
        .where("owner_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      return value.size;
    });
  }

//TODO
  Stream<List<CabinetModel>> drugCount() {
    var myUid = FirebaseAuth.instance.currentUser.uid;
    return collection
        .where("owner_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => CabinetModel.fromMap(e)).toList();
      }
      return [];
    });
  }

//TODO
  Stream<List<CabinetModel>> pillCount() {
    var myUid = FirebaseAuth.instance.currentUser.uid;
    return collection
        .where("owner_id", isEqualTo: myUid)
        .snapshots()
        .map((value) {
      if (value.size > 0) {
        return value.docs.map((e) => CabinetModel.fromMap(e)).toList();
      }
      return [];
    });
  }

  Stream<CabinetModel> getDefaultCabinet(String id) {
    return collection.doc(id).snapshots().map((e) => CabinetModel.fromMap(e));
  }
/*
  Future work: cabinet sharring

  Stream<List<OwnerModel>> streamOwners(String cabinetId) {
    return collection
        .doc(cabinetId)
        .collection(Collections.owners)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((e) {
            return OwnerModel.fromMap(e);
          })
          .where((element) => !element.isAdmin)
          .toList();
    });
  }
  
  */
/*
  Future<void> addOwner(String cabinetId, String newOwnerEmail) async {
    try {
      var user = await UserRepository(context).getByEmail(newOwnerEmail);
      if (user == null) {
        snackBarMessage(context, "User not found");
        return;
      }
      var owner = await getOwner(cabinetId, user.id);
      if (owner != null) {
        snackBarMessage(context, "Already added");
        return;
      }
      collection
          .doc(cabinetId)
          .collection(Collections.owners)
          .add({"user_id": user.id, "admin": false, "email": user.email});
      snackBarMessage(context, "Shared");
    } catch (error) {
      snackBarMessage(context, "Something went wrong");
    }
  }
*/
/*
  Future<OwnerModel> getOwner(String cabinetId, String userId) {
    return collection
        .doc(cabinetId)
        .collection(Collections.owners)
        .where("user_id", isEqualTo: userId)
        .get()
        .then((value) {
      if (value.size > 0) {
        return value.docs.map((e) => OwnerModel.fromMap(e)).toList().first;
      } else {
        return null;
      }
    }).catchError((error) => null);
  }
*/
/*
  Future<void> removeOwner(String cabinetId, String ownerId) async {
    try {
      var owner = await getOwner(cabinetId, ownerId);
      if (owner == null) {
        snackBarMessage(context, "Something went wrong");
        return;
      }
      if (owner.isAdmin) {
        snackBarMessage(context, "Not authorized");
        return;
      }
      collection
          .doc(cabinetId)
          .collection(Collections.owners)
          .doc(owner.id)
          .delete();
      snackBarMessage(context, "Share removed");
    } catch (error) {
      snackBarMessage(context, "Something went wrong");
    }
  }*/

}
