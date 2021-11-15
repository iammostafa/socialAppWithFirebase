import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/user/models/user_model.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  static creatUserInFireStore(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .set(userModel.toMap())
        .then((value) {
      
    }).catchError((e){print(e.toString());});
  }

  // Future<void> getUserData(uid) async {
  //   final result = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('uid', isEqualTo: uid)
  //       .get();

  //   // return UserModel.fromMap(result.docs.first.data());
  // }
}
