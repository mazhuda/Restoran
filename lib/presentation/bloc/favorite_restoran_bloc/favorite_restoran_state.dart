part of 'favorite_restoran_bloc.dart';

abstract class FavoriteRestoranState extends Equatable {
  const FavoriteRestoranState();
}

class FavoriteRestoranInitialState extends FavoriteRestoranState {
  @override
  List<Object> get props => [];
}

class FavoriteRestoranLoadingState extends FavoriteRestoranState {
  @override
  List<Object> get props => [];
}

class FavoriteRestoranFailedState extends FavoriteRestoranState {
  @override
  List<Object> get props => [];
}

class FavoriteRestoranSuccessGetListState extends FavoriteRestoranState {
  final List<RestoranTableData> listRestoranTableData;

  FavoriteRestoranSuccessGetListState({this.listRestoranTableData});

  @override
  List<Object> get props => [listRestoranTableData];
}

class FavoriteRestoranSuccessGetListByIdState extends FavoriteRestoranState {
  final RestoranTableData restoranTableData;

  FavoriteRestoranSuccessGetListByIdState({this.restoranTableData});

  @override
  List<Object> get props => [restoranTableData];
}

class FavoriteRestoranSuccessInsertState extends FavoriteRestoranState {
  @override
  List<Object> get props => [];
}

class FavoriteRestoranSuccessDeleteState extends FavoriteRestoranState {
  @override
  List<Object> get props => [];
}
