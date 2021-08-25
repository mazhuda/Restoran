import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';
import 'package:restoran/domain/usecase/search_restoran_usecase.dart';

class MockRestoranRepository extends Mock implements RestoranRepository {}

void main() {
  RestoranRepository mockRestoranRepository;
  SearchRestoranUseCase searchRestoranUseCase;

  setUp(() {
    mockRestoranRepository = MockRestoranRepository();
    searchRestoranUseCase =
        SearchRestoranUseCaseImpl(restoranRepository: mockRestoranRepository);
  });

  test(
      'method use case call untuk search restoran '
      'dengan parameter id kemudian mempunyai returning data restoran list entity',
      () async {
    RestoranListEntity response;
    when(mockRestoranRepository.searchRestoran('nama restoran'))
        .thenAnswer((_) async => response);

    final result = await searchRestoranUseCase.searchRestoran('nama restoran');
    expect(result, response);
    verify(mockRestoranRepository.searchRestoran('nama restoran'));
    verifyNoMoreInteractions(mockRestoranRepository);
  });
}
