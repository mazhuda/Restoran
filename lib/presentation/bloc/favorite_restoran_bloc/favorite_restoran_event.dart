part of 'favorite_restoran_bloc.dart';

abstract class FavoriteRestoranEvent extends Equatable {
  const FavoriteRestoranEvent();
}

class GetListFavoriteRestoran extends FavoriteRestoranEvent {
  @override
  List<Object> get props => [];
}

class GetListFavoriteRestoranById extends FavoriteRestoranEvent {
  final String id;

  GetListFavoriteRestoranById({this.id});

  @override
  List<Object> get props => [id];
}

class InsertFavoriteRestoran extends FavoriteRestoranEvent {
  final RestoranTableData restoranTableData;

  InsertFavoriteRestoran({this.restoranTableData});

  @override
  List<Object> get props => [restoranTableData];
}

class DeleteFavoriteRestoran extends FavoriteRestoranEvent {
  final RestoranTableData restoranTableData;

  DeleteFavoriteRestoran({this.restoranTableData});

  @override
  List<Object> get props => [restoranTableData];
}
