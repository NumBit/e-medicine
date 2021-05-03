import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/firebase/repository.dart';
import 'package:medicine_cabinet/firebase/constants/collections.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_model.dart';
import 'package:medicine_cabinet/firebase/user/user_cabinet_repository.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

class CabinetRepository extends Repository<CabinetModel> {
  CabinetRepository()
      : super(
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

    model = CabinetModel(name: model.name);
    try {
      cabinet = await collection.add(model.toJson());
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
    }
    return cabinet.id;
  }

  Future<String> addToAuthUser(CabinetModel model) async {
    DocumentReference cabinet;
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    try {
      cabinet = await collection.add(model.toJson());
      await UserCabinetRepository().add(UserCabinetModel(
          userId: user.uid,
          userEmail: user.email,
          cabinetId: cabinet.id,
          admin: true));
    } catch (e) {
      snackBarMessage("Something went wrong", "Try again later");
      return null;
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

//TODO not the right count, use per UserCabinet
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
