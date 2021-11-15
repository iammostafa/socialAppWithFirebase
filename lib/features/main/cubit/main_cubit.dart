import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/features/user/models/user_model.dart';
import 'package:social_app/main.dart';

part 'main_cubit_state.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  UserModel? user;
  List<UserModel>? users = [];
  Future<UserModel> getUserData(uid) async {
    emit(MainCubitLoading());
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    await getUsers().then((value) {});
    emit(MainCubitSuccess());
    user = UserModel.fromMap(result.docs.first.data());
    return UserModel.fromMap(result.docs.first.data());
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> ll = [];
    var s;
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: tokenValue)
        .get()
        .then((value) {
      s = value.docs;
      for (var user in s) {
        ll.add(UserModel.fromMap(user.data()));
      }
    });
    users!.addAll(ll);
    return ll;
  }

  getLastMessageofUser({String? myId , String? userId}) async {
    String result ='';
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$userId') // other user id
        .collection('chats')
        .doc('$myId') // my id
        .collection('messages')
        .get()
        .then((value) {
      print('${value.docs.first.data()["message"]}');
      result = value.docs.first.data()["message"];
    });
    

    return result;
  }

  logout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
