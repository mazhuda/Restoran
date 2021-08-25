import 'package:restoran/data/local/model/restoran_table.dart';

abstract class LocalDataSource {
  Future<List<RestoranTableData>> getFavoriteRestoranList();

  Future<RestoranTableData> getFavoriteRestoranById(String id);

  Future insertFavoriteRestoran(RestoranTableData restoranTableData);

  Future deleteFavoriteRestoran(RestoranTableData restoranTableData);
}

class LocalDataSourceImpl extends LocalDataSource {
  AppDatabase appDatabase;

  LocalDataSourceImpl({this.appDatabase});

  @override
  Future deleteFavoriteRestoran(RestoranTableData restoranTableData) =>
      appDatabase.restoranDao.deleteFavoriteRestoran(restoranTableData);

  @override
  Future<RestoranTableData> getFavoriteRestoranById(String id) =>
      appDatabase.restoranDao.getFavoriteRestoranById(id);

  @override
  Future<List<RestoranTableData>> getFavoriteRestoranList() =>
      appDatabase.restoranDao.getFavoriteRestoranList();

  @override
  Future insertFavoriteRestoran(RestoranTableData restoranTableData) =>
      appDatabase.restoranDao.insertFavoriteRestoran(restoranTableData);
}
