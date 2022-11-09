import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shikishaseller/models/products_model.dart';
import 'package:shikishaseller/services/product_service.dart';

final productProvider = Provider<ProductsService>((ref) => ProductsService());

FirebaseAuth auth = FirebaseAuth.instance;

ProductsService _products = ProductsService();
final userProduct = FutureProvider<List<ProductModel>>((ref) async {
  return _products.userProducts(auth.currentUser!.phoneNumber);
});
