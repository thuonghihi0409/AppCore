part of 'search_bloc.dart';

@immutable
class SearchState extends Equatable {
  final List<Product> filteredProducts;
  final bool isSearching;

  const SearchState({
    this.filteredProducts = const [],
    this.isSearching = false,
  });

  SearchState copyWith({
    List<Product>? filteredProducts,
    bool? isSearching,
  }) {
    return SearchState(
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [filteredProducts, isSearching];
}
