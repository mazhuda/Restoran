part of 'get_detail_restoran_bloc.dart';

abstract class GetDetailRestoranState extends Equatable {
  const GetDetailRestoranState();
}

class GetDetailRestoranInitialState extends GetDetailRestoranState {
  @override
  List<Object> get props => [];
}

class GetDetailRestoranLoadingState extends GetDetailRestoranState {
  @override
  List<Object> get props => [];
}

class GetDetailRestoranLoadedState extends GetDetailRestoranState {
  final DetailRestoranEntity detailRestoran;

  GetDetailRestoranLoadedState({this.detailRestoran});

  @override
  List<Object> get props => [detailRestoran];
}

class GetDetailRestoranFailedState extends GetDetailRestoranState {
  final String message;

  GetDetailRestoranFailedState({this.message});

  @override
  List<Object> get props => [message];
}
