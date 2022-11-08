import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shikishaseller/services/product_service.dart';

final productProvider = Provider<ProductsService>((ref) => ProductsService());
