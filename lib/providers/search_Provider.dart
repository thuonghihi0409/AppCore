import 'package:appcore/models/product.dart';
import 'package:appcore/utils/data.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {

  List<Product> _filteredProducts = [];
  List<Product> get filteredProducts => _filteredProducts.isEmpty ? products_data : _filteredProducts;

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = products_data
          .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();  // Thông báo cho UI khi có sự thay đổi
  }
}
