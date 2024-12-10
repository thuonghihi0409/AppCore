import 'dart:core';

import 'package:appcore/models/category.dart';
import 'package:appcore/models/paymentmethod.dart';
import 'package:appcore/models/product.dart';

final List<Product> products_data = [
  Product(
    title: 'Girl T-shirt with jeans pant',
    description: 'Trendy girl outfit',
    price: 34,
    imageUrls: ["https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages.jpg?alt=media&token=395957de-961b-4fc5-8df6-35582a82f23c",
    "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(1).jpg?alt=media&token=069b0eb5-a66e-4c66-b49b-067f26b11cf9",
    "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(2).jpg?alt=media&token=4a64888b-8e99-4402-9a08-fddf3e0389b1"],
    id: '01',
    category: '',
  ),
  Product(
    title: 'Stylish Jacket',
    description: 'Perfect for winter',
    price: 45,
    imageUrls: ["https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(3).jpg?alt=media&token=1e93b82e-2335-40c5-a252-a6ad59a79303",
      "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(1).jpg?alt=media&token=069b0eb5-a66e-4c66-b49b-067f26b11cf9",
      "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(2).jpg?alt=media&token=4a64888b-8e99-4402-9a08-fddf3e0389b1"],
    id: '02',
    category: '',
  ),
  Product(
    title: 'Girl T-shirt with jeans pant',
    description: 'Trendy girl outfit',
    price: 34,
    imageUrls: ["https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(2).jpg?alt=media&token=4a64888b-8e99-4402-9a08-fddf3e0389b1",
      "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(1).jpg?alt=media&token=069b0eb5-a66e-4c66-b49b-067f26b11cf9",
      "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(2).jpg?alt=media&token=4a64888b-8e99-4402-9a08-fddf3e0389b1"],
    id: '03',
    category: '',
  ),

  Product(
    title: 'Girl T-shirt with jeans pant',
    description: 'Trendy girl outfit',
    price: 34,
    imageUrls: ["https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(1).jpg?alt=media&token=069b0eb5-a66e-4c66-b49b-067f26b11cf9",
      "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(1).jpg?alt=media&token=069b0eb5-a66e-4c66-b49b-067f26b11cf9",
      "https://firebasestorage.googleapis.com/v0/b/timtro-f9635.appspot.com/o/images%2Fimages%20(2).jpg?alt=media&token=4a64888b-8e99-4402-9a08-fddf3e0389b1"],
    id: '04',
    category: '',
  ),
];

final List<Category> categories_data = [
  Category(id: "01", title: "Men"),
  Category(id: "02", title: "Women"),
  Category(id: "03", title: "Children"),
];

final List<PaymentMethod> pamentmethod_data =[
  PaymentMethod(id: "01", stk: "2222 3333 4444 4242", dateTime: DateTime(2024,12)),
  PaymentMethod(id: "02", stk: "1111 2222 3333 4242", dateTime: DateTime(2024,12)),
];