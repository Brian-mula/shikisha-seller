import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shikishaseller/models/products_model.dart';
import 'package:shikishaseller/models/user_model.dart';

class ProductsContoller {
  bool isExisting = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection("products");

  // !get all products
  Future<List<ProductModel>> get allProducts async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("products").get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  Future<List<ProductModel>> userProducts(UserModel user) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection("products")
        .where('phone', isEqualTo: user.phone)
        .get();
    isExisting = true;
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  // ! add a product
  Future<void> addProduct(ProductModel product, UserModel user) async {
    try {
      await _products.doc(user.id).set({
        "title": product.title,
        "category": product.category,
        "description": product.description,
        "price": product.price,
        "image": product.img,
        "seller": product.seller,
        "phone": product.phone
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
