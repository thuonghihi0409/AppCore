import 'package:appcore/utils/data.dart';
import 'package:flutter/foundation.dart';
import 'package:appcore/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _favoriteProducts = [];


  List<Product> get products => _products;

  List<Product> get favoriteProducts => _favoriteProducts;

 void updateUI(){
   notifyListeners();
 }
  void loadProducts() {
    _products = products_data;
    updateUI();
  }

  Future<void> loadFavorites() async {

    updateUI();
  }


  Future<void> addToFavorites(Product product) async {
    _favoriteProducts.add(product);
    updateUI();
  }


  Future<void> removeFromFavorites(String productId) async {

    _favoriteProducts.removeWhere((product) => product.id == productId);
    updateUI();
  }


  bool isFavorite(String productId) {
    return _favoriteProducts.any((product) => product.id == productId);
  }
}
