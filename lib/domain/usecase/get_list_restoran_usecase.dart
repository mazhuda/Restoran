import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';

abstract class GetListRestoranUseCase {
  Future<RestoranListEntity> getListRestoran();
}

class GetListRestoranUseCaseImpl extends GetListRestoranUseCase {
  RestoranRepository restoranRepository;

  GetListRestoranUseCaseImpl({this.restoranRepository});

  @override
  Future<RestoranListEntity> getListRestoran() =>
      restoranRepository.getListRestoran();
}
