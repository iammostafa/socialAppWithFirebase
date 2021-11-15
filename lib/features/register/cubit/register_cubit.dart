import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/main/screens/main_screen.dart';
import 'package:social_app/features/user/cubit/user_cubit.dart';
import 'package:social_app/features/user/models/user_model.dart';
import 'package:social_app/global/navigation.dart';
import 'package:social_app/global/spManager.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  FirebaseAuth _auth = FirebaseAuth.instance;
  static RegisterCubit get(context) => BlocProvider.of(context);
  late String errorMessage;
  late User _user;
  createUserWithEmailAndPassword(name, email, password, phone, context) async {
    emit(RegisterLoading());
    await emailCheck(email).then((value) async {
      if (value == true) {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          emit(RegisterSuccess());
          _user = value.user!;
          CacheHelper.saveData(key: 'Token', value: _user.uid);
          UserModel _userModel = UserModel(
              name: '$name',
              email: '$email',
              phone: '$phone',
              fcmToken: '',
              photoUrl: '',
              verified: false,
              uid: _user.uid);
          UserCubit.creatUserInFireStore(_userModel);
          Navigation.goTo(context, MainScreen());
          print(_user);
        }).catchError((e) {
          switch (e.code) {
            case "email-already-in-use":
              errorMessage = "Your email already in user.";
              Fluttertoast.showToast(msg: errorMessage);
              break;
            case "ERROR_WRONG_PASSWORD":
              errorMessage = "Your password is wrong.";
              break;
            case "ERROR_USER_NOT_FOUND":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "ERROR_USER_DISABLED":
              errorMessage = "User with this email has been disabled.";
              break;
            case "ERROR_TOO_MANY_REQUESTS":
              errorMessage = "Too many requests. Try again later.";
              break;
            case "ERROR_OPERATION_NOT_ALLOWED":
              errorMessage =
                  "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          emit(RegisterFailed(errorMessage));
        });
      } else {
        Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: 'You already registered with the same email');
      }
      ;
    });
  }

  Future<bool> emailCheck(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docChanges.isEmpty;
  }
}
