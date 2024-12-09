import 'dart:core';

import 'package:appcore/models/category.dart';
import 'package:appcore/models/product.dart';

final List<Product> products_data = [
  Product(
    title: 'Girl T-shirt with jeans pant',
    description: 'Trendy girl outfit',
    price: 34.0,
    imageUrl: 'https://via.placeholder.com/150',
    id: '01',
    category: '',
  ),
  Product(
    title: 'Stylish Jacket',
    description: 'Perfect for winter',
    price: 45.0,
    imageUrl: 'https://via.placeholder.com/150',
    id: '02',
    category: '',
  ),
];

final List<Category> categories_data = [
  Category(id: "01", title: "Men"),
  Category(id: "02", title: "Women"),
  Category(id: "03", title: "Children"),
];
