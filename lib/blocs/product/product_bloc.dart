
import 'package:appcore/models/product.dart';
import 'package:appcore/utils/data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<SelectProduct>(_onSelectProduct);
    on<FavariteProduct>(_onFavariteProduct);
    on<UnFavariteProduct>(_onUnFavariteProduct);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    emit(state.copyWith(isLoading: true));

    // Giả lập tải danh sách sản phẩm
    Future.delayed(Duration(seconds: 1), () {
      final products = products_data;
      emit(state.copyWith(products: products, isLoading: false));
    });
  }

  void _onAddProduct(AddProduct event, Emitter<ProductState> emit) {
    final newProduct = Product(
      price: event.price,
      title: '',
      description: '',
      category: '',
      imageUrls: [],
      id: '',
    );
    final updatedProducts = List<Product>.from(state.products)..add(newProduct);
    emit(state.copyWith(products: updatedProducts));
  }

  void _onFavariteProduct(FavariteProduct event, Emitter<ProductState> emit) {
    print(" ========FavariteProduct");
    List<String> list = List.from(state.favoriteProducts);
    list.add(event.id);
    emit(state.copyWith(favoriteProducts: list));
  }

  void _onUnFavariteProduct(
      UnFavariteProduct event, Emitter<ProductState> emit) {
    print(" ========UnFavariteProduct");
    List<String> list = List.from(state.favoriteProducts);
    list.remove(event.id);
    emit(state.copyWith(favoriteProducts: list));
  }

  void _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) {
    final updatedProducts = state.products.map((product) {
      if (product.id == event.id) {
        return Product(
            id: product.id,
            price: event.price,
            title: '',
            description: '',
            imageUrls: [],
            category: '');
      }
      return product;
    }).toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) {
    final updatedProducts =
        state.products.where((product) => product.id != event.id).toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void _onSelectProduct(SelectProduct event, Emitter<ProductState> emit) {
    final selectedProduct =
        state.products.firstWhere((product) => product.id == event.id);
    emit(state.copyWith(selectedProduct: selectedProduct));
  }
}
