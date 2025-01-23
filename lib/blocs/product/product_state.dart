part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final List<Product> products;
  final Product? selectedProduct;
  final List<String> favoriteProducts;
  final bool isLoading;

  ProductState({
    this.products = const [],
    this.selectedProduct,
    this.isLoading = false,
    this.favoriteProducts = const ["01", "03"],
  });

  ProductState copyWith(
      {List<Product>? products,
      Product? selectedProduct,
      bool? isLoading,
      List<String>? favoriteProducts}) {
    return ProductState(
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      isLoading: isLoading ?? this.isLoading,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }

  @override
  List<Object?> get props => [products, selectedProduct ?? '', isLoading];
}
