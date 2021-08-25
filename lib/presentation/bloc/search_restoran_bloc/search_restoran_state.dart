part of 'search_restoran_bloc.dart';

abstract class SearchRestoranState extends Equatable {
  const SearchRestoranState();
}

class SearchRestoranInitialState extends SearchRestoranState {
  @override
  List<Object> get props => [];
}

class SearchRestoranLoadingState extends SearchRestoranState {
  @override
  List<Object> get props => [];
}

class SearchRestoranLoadedState extends SearchRestoranState {
  final List<RestoranEntity> listRestoran;

  SearchRestoranLoadedState({this.listRestoran});

  @override
  List<Object> get props => [listRestoran];
}

class SearchRestoranFailedState extends SearchRestoranState {
  final String message;

  SearchRestoranFailedState({this.message});

  @override
  List<Object> get props => [message];
}
