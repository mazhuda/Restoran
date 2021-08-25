part of 'get_list_restoran_bloc.dart';

abstract class GetListRestoranState extends Equatable {
  const GetListRestoranState();
}

class GetListRestoranInitialState extends GetListRestoranState {
  @override
  List<Object> get props => [];
}

class GetListRestoranLoadingState extends GetListRestoranState {
  @override
  List<Object> get props => [];
}

class GetListRestoranLoadedState extends GetListRestoranState {
  final List<RestoranEntity> listRestoran;

  GetListRestoranLoadedState({this.listRestoran});

  @override
  List<Object> get props => [listRestoran];
}

class GetListRestoranFailedState extends GetListRestoranState {
  final String message;

  GetListRestoranFailedState({this.message});

  @override
  List<Object> get props => [message];
}
