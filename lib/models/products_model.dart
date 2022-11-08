import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String title;
  String category;
  String description;
  bool isVerified;
  String img;
  int price;
  String? seller;
  String? phone;

  ProductModel(
      {this.id,
      required this.isVerified,
      required this.title,
      required this.category,
      required this.description,
      required this.img,
      required this.price,
      this.seller,
      this.phone});

  Map<String, dynamic> toSnapshot() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'isVerified': isVerified,
      'img': img,
      'price': price,
      'seller': seller,
      'phone': phone,
    };
  }

  ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!["title"],
        category = doc.data()!['category'],
        price = doc.data()!['price'],
        description = doc.data()!['description'],
        isVerified = doc.data()!['isVerified'],
        img = doc.data()!['image'],
        seller = doc.data()!['seller'],
        phone = doc.data()!['phone'];

  String toJson() => json.encode(toSnapshot());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromSnapshot(json.decode(source));
}
