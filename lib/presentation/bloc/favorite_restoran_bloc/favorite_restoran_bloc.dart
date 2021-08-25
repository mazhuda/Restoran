import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restoran/data/local/model/restoran_table.dart';
import 'package:restoran/domain/usecase/favorite_restoran_usecase.dart';

part 'favorite_restoran_event.dart';

part 'favorite_restoran_state.dart';

class FavoriteRestoranBloc
    extends Bloc<FavoriteRestoranEvent, FavoriteRestoranState> {
  FavoriteRestoranUseCase favoriteRestoranUseCase;

  FavoriteRestoranBloc({this.favoriteRestoranUseCase})
      : super(FavoriteRestoranInitialState());

  @override
  Stream<FavoriteRestoranState> mapEventToState(
      FavoriteRestoranEvent event) async* {
    if (event is GetListFavoriteRestoran) {
      yield FavoriteRestoranLoadingState();
      var listFavoriteRestoran =
          await favoriteRestoranUseCase.getFavoriteRestoranList();
      if (listFavoriteRestoran.isEmpty) {
        yield FavoriteRestoranFailedState();
      } else {
        yield FavoriteRestoranSuccessGetListState(
            listRestoranTableData: listFavoriteRestoran);
      }
    } else if (event is GetListFavoriteRestoranById) {
      yield FavoriteRestoranLoadingState();
      var favoriteRestoran =
          await favoriteRestoranUseCase.getFavoriteRestoranById(event.id);
      if (favoriteRestoran != null) {
        yield FavoriteRestoranSuccessGetListByIdState(
            restoranTableData: favoriteRestoran);
      } else {
        yield FavoriteRestoranFailedState();
      }
    } else if (event is InsertFavoriteRestoran) {
      try {
        yield FavoriteRestoranLoadingState();
        await favoriteRestoranUseCase
            .insertFavoriteRestoran(event.restoranTableData);
        yield FavoriteRestoranSuccessInsertState();
      } catch (e) {
        yield FavoriteRestoranFailedState();
      }
    } else if (event is DeleteFavoriteRestoran) {
      try {
        yield FavoriteRestoranLoadingState();
        await favoriteRestoranUseCase
            .deleteFavoriteRestoran(event.restoranTableData);
        yield FavoriteRestoranSuccessDeleteState();
      } catch (e) {
        yield FavoriteRestoranFailedState();
      }
    }
  }
}
