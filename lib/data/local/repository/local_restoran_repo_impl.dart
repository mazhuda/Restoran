import 'package:restoran/data/local/datasource/local_data_source.dart';
import 'package:restoran/data/local/model/restoran_table.dart';
import 'package:restoran/domain/repository/local_restoran_repo.dart';

class LocalRestoranRepositoryImpl extends LocalRestoranRepository {
  LocalDataSource localDataSource;

  LocalRestoranRepositoryImpl({this.localDataSource});

  @override
  Future deleteFavoriteRestoran(RestoranTableData restoranTableData) =>
      localDataSource.deleteFavoriteRestoran(restoranTableData);

  @override
  Future<RestoranTableData> getFavoriteRestoranById(String id) =>
      localDataSource.getFavoriteRestoranById(id);

  @override
  Future<List<RestoranTableData>> getFavoriteRestoranList() =>
      localDataSource.getFavoriteRestoranList();

  @override
  Future insertFavoriteRestoran(RestoranTableData restoranTableData) =>
      localDataSource.insertFavoriteRestoran(restoranTableData);
}
