import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/firebase/model.dart';
import 'package:medicine_cabinet/main/snack_bar_message.dart';

abstract class Repository<T extends Model> {
  late CollectionReference collection;

  Repository(CollectionReference collection) {
    this.collection = collection;
  }

  Stream<T?> streamModel(String? id);

  Future<String?> add(T model) {
    return collection
        .add(model.toJson())
        .then((value) => value.id)
        .catchError((error) {
      snackBarMessage("Operation failed", "Nothing added");
      return "";
    });
  }

  void update(T model) {
    collection
        .doc(model.id)
        .update(model.toJson())
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing updated"));
  }

  void delete(String? docId) {
    collection
        .doc(docId)
        .delete()
        .then((value) => print("Operation success."))
        .catchError(
            (error) => snackBarMessage("Operation failed", "Nothing removed"));
  }
}
