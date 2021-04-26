import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(FirebaseAuth.instance));

  void setAuth(auth) {
    final newAuth = UserState(auth);
    emit(newAuth);
  }
  /*
  void register(auth,email, password) {
    emit(UserState(auth)
        .auth
        .signInWithEmailAndPassword(email: email, password: password));
  }
  */
}
