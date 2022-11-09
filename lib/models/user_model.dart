import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String phone;

  UserModel({required this.name, required this.phone, required this.id});

  Map<String, dynamic> toSnapshot() {
    return {
      "id": id,
      'name': name,
      'phone': phone,
    };
  }

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!['name'],
        phone = doc.data()!['phone'];

  String toJson() => json.encode(toSnapshot());

  factory UserModel.fromJson(String source) =>
      UserModel.fromSnapshot(json.decode(source));
}
