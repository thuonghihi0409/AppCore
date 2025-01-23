part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends SearchEvent {}