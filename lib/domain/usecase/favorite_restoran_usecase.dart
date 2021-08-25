import 'package:restoran/data/local/model/restoran_table.dart';
import 'package:restoran/domain/repository/local_restoran_repo.dart';

abstract class FavoriteRestoranUseCase {
  Future insertFavoriteRestoran(RestoranTableData restoranTableData);

  Future deleteFavoriteRestoran(RestoranTableData restoranTableData);

  Future<RestoranTableData> getFavoriteRestoranById(String id);

  Future<List<RestoranTableData>> getFavoriteRestoranList();
}

class FavoriteRestoranUseCaseImpl extends FavoriteRestoranUseCase {
  LocalRestoranRepository localRestoranRepository;

  FavoriteRestoranUseCaseImpl({this.localRestoranRepository});

  @override
  Future insertFavoriteRestoran(RestoranTableData restoranTableData) =>
      localRestoranRepository.insertFavoriteRestoran(restoranTableData);

  @override
  Future deleteFavoriteRestoran(RestoranTableData restoranTableData) =>
      localRestoranRepository.deleteFavoriteRestoran(restoranTableData);

  @override
  Future<RestoranTableData> getFavoriteRestoranById(String id) =>
      localRestoranRepository.getFavoriteRestoranById(id);

  @override
  Future<List<RestoranTableData>> getFavoriteRestoranList() =>
      localRestoranRepository.getFavoriteRestoranList();
}
