import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/add_review_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';
import 'package:restoran/domain/usecase/add_review_usecase.dart';

class MockRestoranRepository extends Mock implements RestoranRepository {}

void main() {
  RestoranRepository mockRestoranRepository;
  AddReviewUseCase addReviewUseCase;

  setUp(() {
    mockRestoranRepository = MockRestoranRepository();
    addReviewUseCase =
        AddReviewUseCaseImpl(restoranRepository: mockRestoranRepository);
  });

  test(
      'method use case call add review '
      'dengan parameter id, user name, dan saran kemudian mempunyai returning data object add review entity',
      () async {
    AddReviewsEntity response;
    when(mockRestoranRepository.addReview(
            "rqdv5juczeskfw1e867", "Bang Jago", "Tempatnya enak buat ngedate"))
        .thenAnswer((_) async => response);

    final result = await addReviewUseCase.addReview(
        "rqdv5juczeskfw1e867", "Bang Jago", "Tempatnya enak buat ngedate");
    expect(result, response);
    verify(mockRestoranRepository.addReview(
        "rqdv5juczeskfw1e867", "Bang Jago", "Tempatnya enak buat ngedate"));
    verifyNoMoreInteractions(mockRestoranRepository);
  });
}
