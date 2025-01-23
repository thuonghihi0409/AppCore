import 'package:appcore/models/product.dart';
import 'package:appcore/utils/data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ClearSearch>(_onClearSearch);
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(filteredProducts: products_data));
    } else {
      final filteredProducts = products_data
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();
      emit(state.copyWith(filteredProducts: filteredProducts));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(state.copyWith(filteredProducts: products_data));
  }
}
