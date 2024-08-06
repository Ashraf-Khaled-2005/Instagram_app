import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String pass, email, username, image, uid;

  final List Followers;
  final List Following, stories;

  UserModel(
      {required this.pass,
      required this.email,
      required this.username,
      required this.image,
      required this.uid,
      required this.Followers,
      required this.Following,
      required this.stories});

  factory UserModel.fromdocu(DocumentSnapshot json) {
    return UserModel(
        pass: json['password'],
        email: json['email'],
        username: json['username'],
        image: json['imageurl'],
        uid: json['uid'],
        Followers: json['followers'],
        Following: json['following'],
        stories: json['stories']);
  }
}
