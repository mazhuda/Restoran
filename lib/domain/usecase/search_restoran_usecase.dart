import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';

abstract class SearchRestoranUseCase {
  Future<RestoranListEntity> searchRestoran(String restoranName);
}

class SearchRestoranUseCaseImpl extends SearchRestoranUseCase {
  RestoranRepository restoranRepository;

  SearchRestoranUseCaseImpl({this.restoranRepository});

  @override
  Future<RestoranListEntity> searchRestoran(String restoranName) =>
      restoranRepository.searchRestoran(restoranName);
}
