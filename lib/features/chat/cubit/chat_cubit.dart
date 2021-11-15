import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/chat/models/chat_model.dart';
import 'package:social_app/features/user/models/user_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  sendMessage(UserModel user, senderId, recieverId, message) {
    ChatModel _chatModel = ChatModel(
        message: message,
        dateTime: DateTime.now().toString(),
        senderId: senderId,
        recieverId: recieverId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(_chatModel.toMap())
        .then((value) => emit(ChatSuccess()))
        .catchError((e) {
      emit(ChatFailed());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .add(_chatModel.toMap())
        .then((value) => emit(ChatSuccess()))
        .catchError((e) {
      emit(ChatFailed());
    });
  }

  List<ChatModel> messagesList = [];
  List<ChatModel> messagesList2 = [];

  void getMessages(
    UserModel user,
    senderId,
    recieverId,
  ) {
    print(recieverId);
    print(senderId);
    emit(ChatLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      emit(ChatSuccess());
      messagesList = [];
      messagesList2 = [];

      event.docs.forEach((element) {
        messagesList.add(ChatModel.fromMap(element.data()));
        // messagesList2.addAll(messagesList.reversed);
        //  messagesList.addAll(messagesList.reversed)   ;
        // messagesList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        // _scrollController.animateTo(
        //     _scrollController.position.maxScrollExtent * 1.1,
        //     duration: const Duration(milliseconds: 400),
        //     curve: Curves.fastOutSlowIn);
      });
      messagesList2.addAll(messagesList.reversed);
    });
  }

  addFriend(
    String uid,
    senderId,
    recieverId,
  ) {
    Map<String, dynamic> map = {'uid': '1221212'};
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('friends')
        .add(map);
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('friends')
        .add(map);
  }
}
