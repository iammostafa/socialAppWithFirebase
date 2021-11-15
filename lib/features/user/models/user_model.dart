import 'dart:convert';

class UserModel {
  late String name;
  late String email;
  late String phone;
  late String photoUrl;
  late String uid;
  late bool verified;
  late String fcmToken;
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.verified,
    required this.fcmToken,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'verified': verified,
      'fcmToken': fcmToken,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      uid: map['uid'],
      verified: map['verified'],
      fcmToken: map['fcmToken'],
      photoUrl: map['photoUrl'] == null ? '' : map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
