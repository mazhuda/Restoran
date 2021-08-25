import 'package:moor_flutter/moor_flutter.dart';

part 'restoran_table.g.dart';

class RestoranTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  TextColumn get pictureId => text()();

  TextColumn get city => text()();

  TextColumn get address => text()();

  TextColumn get rating => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [RestoranTable], daos: [RestoranDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;
}

@UseDao(tables: [RestoranTable])
class RestoranDao extends DatabaseAccessor<AppDatabase>
    with _$RestoranDaoMixin {
  RestoranDao(AppDatabase db) : super(db);
  Future<List<RestoranTableData>> getFavoriteRestoranList() =>
      select(restoranTable).get();

  Future<RestoranTableData> getFavoriteRestoranById(String id) =>
      (select(restoranTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future insertFavoriteRestoran(RestoranTableData restoranTableData) =>
      into(restoranTable).insert(restoranTableData);

  Future deleteFavoriteRestoran(RestoranTableData restoranTableData) =>
      delete(restoranTable).delete(restoranTableData);
}
