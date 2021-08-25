import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';

abstract class GetRestoranDetailUseCase {
  Future<DetailRestoranEntity> getRestoranDetail(String restoranId);
}

class GetRestoranDetailUseCaseImpl extends GetRestoranDetailUseCase {
  RestoranRepository restoranRepository;

  GetRestoranDetailUseCaseImpl({this.restoranRepository});

  @override
  Future<DetailRestoranEntity> getRestoranDetail(String restoranId) =>
      restoranRepository.getRestoranDetail(restoranId);
}
