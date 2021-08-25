part of 'search_restoran_bloc.dart';

abstract class SearchRestoranEvent extends Equatable {
  const SearchRestoranEvent();
}

class SearchRestoran extends SearchRestoranEvent {
  final String searchText;

  SearchRestoran({this.searchText});

  @override
  List<Object> get props => [];
}
