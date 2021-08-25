import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';
import 'package:restoran/domain/usecase/get_restoran_detail_usecase.dart';

class MockRestoranRepository extends Mock implements RestoranRepository {}

void main() {
  RestoranRepository mockRestoranRepository;
  GetRestoranDetailUseCase getRestoranDetailUseCase;

  setUp(() {
    mockRestoranRepository = MockRestoranRepository();
    getRestoranDetailUseCase = GetRestoranDetailUseCaseImpl(
        restoranRepository: mockRestoranRepository);
  });

  test(
      'method use case call get restoran '
      'dengan parameter id kemudian mempunyai returning data detail restoran entity',
      () async {
    DetailRestoranEntity response;
    when(mockRestoranRepository.getRestoranDetail("id"))
        .thenAnswer((_) async => response);

    final result = await getRestoranDetailUseCase.getRestoranDetail('id');
    expect(result, response);
    verify(mockRestoranRepository.getRestoranDetail('id'));
    verifyNoMoreInteractions(mockRestoranRepository);
  });
}
