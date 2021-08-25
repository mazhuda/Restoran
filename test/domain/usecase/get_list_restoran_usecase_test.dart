import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';
import 'package:restoran/domain/usecase/get_list_restoran_usecase.dart';

class MockRestoranRepository extends Mock implements RestoranRepository {}

void main() {
  RestoranRepository mockRestoranRepository;
  GetListRestoranUseCase getListRestoranUseCase;

  setUp(() {
    mockRestoranRepository = MockRestoranRepository();
    getListRestoranUseCase =
        GetListRestoranUseCaseImpl(restoranRepository: mockRestoranRepository);
  });

  test(
      'method use case call get list restoran '
      'mempunyai returning data berupa restoran list entity', () async {
    RestoranListEntity response;
    when(mockRestoranRepository.getListRestoran())
        .thenAnswer((_) async => response);

    final result = await getListRestoranUseCase.getListRestoran();
    expect(result, response);
    verify(mockRestoranRepository.getListRestoran());
    verifyNoMoreInteractions(mockRestoranRepository);
  });
}
