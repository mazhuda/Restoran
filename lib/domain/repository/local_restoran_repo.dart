import 'package:restoran/data/local/model/restoran_table.dart';

abstract class LocalRestoranRepository {
  Future<List<RestoranTableData>> getFavoriteRestoranList();

  Future<RestoranTableData> getFavoriteRestoranById(String id);

  Future insertFavoriteRestoran(RestoranTableData restoranTableData);

  Future deleteFavoriteRestoran(RestoranTableData restoranTableData);
}
