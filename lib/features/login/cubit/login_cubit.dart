import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/main/screens/main_screen.dart';
import 'package:social_app/features/user/models/user_model.dart';
import 'package:social_app/global/navigation.dart';
import 'package:social_app/global/spManager.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  getUser() => _user;

  signInWithEmailAndPassword(email, password, c) async {
    emit(LoginLoading());
    print('sign in with $email');

    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print('value $value');

      emit(LoginSuccess());
      _user = value.user!;
      CacheHelper.saveData(key: 'Token', value: _user.uid);
      Navigation.goTo(c, MainScreen());
      print(_user);
    }).catchError((e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.code, timeInSecForIosWeb: 2);
      switch (e.code) {
        case "email-already-in-use":
          e = "Your email already in user.";
          Fluttertoast.showToast(msg: e);
          break;
        case "ERROR_WRONG_PASSWORD":
          e = "Your password is wrong.";
          Fluttertoast.showToast(msg: e);
          break;
        case "user_not_found":
          e = "Your password is wrong.";
          Fluttertoast.showToast(msg: e.code);
          break;
        default:
          e = "An undefined Error happened.";
          Fluttertoast.showToast(msg: e.code);
      }
      emit(LoginFaild(e.toString()));
    });
  }

  Future<User?> signInWithGoogle(c) async {
    User? user;
    emit(LoginGmailLoading());
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    print('sdasd');

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      print('mmmm');

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        user = userCredential.user;

        CacheHelper.saveData(key: 'Token', value: user!.uid);
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        UserModel _userModel = UserModel(
            name: '${user.displayName}',
            email: '${user.email}',
            fcmToken: fcmToken!,
            photoUrl: user.photoURL!,
            phone: '',
            verified: false,
            uid: user.uid);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(_userModel.toMap())
            .then((value) {})
            .catchError((e) {
          print(e.toString());
        });
        //  await UserCubit.creatUserInFireStore(_userModel);
        Navigation.goTo(c, MainScreen());
      } on FirebaseAuthException catch (e) {
        print(e.code);
        LoginGmailFailed(e.code);
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    emit(LoginGmailSuccess());

    return user;
  }

  
}
