import 'dart:convert';

class ChatModel {
  String message;
  String dateTime;
  String senderId;
  String recieverId;
  ChatModel({
    required this.message,
    required this.dateTime,
    required this.senderId,
    required this.recieverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'dateTime': dateTime,
      'senderId': senderId,
      'recieverId': recieverId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: map['message'],
      dateTime: map['dateTime'],
      senderId: map['senderId'],
      recieverId: map['recieverId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}
