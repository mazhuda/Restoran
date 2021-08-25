import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/add_review_entity.dart';
import 'package:restoran/domain/usecase/add_review_usecase.dart';
import 'package:restoran/presentation/bloc/add_review/add_review_bloc.dart';

class MockAddReviewUseCase extends Mock implements AddReviewUseCase {}

void main() {
  AddReviewUseCase mockAddReviewUseCase;

  setUp(() {
    mockAddReviewUseCase = MockAddReviewUseCase();
  });

  blocTest<AddReviewBloc, AddReviewState>(
    'test add review bloc untuk AddReviewLoadingState, AddReviewSuccessState',
    build: () {
      AddReviewsEntity response =
          AddReviewsEntity(message: "message", error: false);
      when(mockAddReviewUseCase.addReview("id", 'name', 'review'))
          .thenAnswer((_) async => response);
      return AddReviewBloc(addReviewUseCase: mockAddReviewUseCase);
    },
    act: (bloc) => bloc
        .add(AddReview(restoranId: 'id', userName: 'name', review: 'review')),
    expect: () => [AddReviewLoadingState(), AddReviewSuccessState()],
  );

  blocTest<AddReviewBloc, AddReviewState>(
    'test add review bloc untuk AddReviewLoadingState, AddReviewFailedState',
    build: () {
      AddReviewsEntity response =
          AddReviewsEntity(message: "message", error: true);
      when(mockAddReviewUseCase.addReview("id", 'name', 'review'))
          .thenAnswer((_) async => response);
      return AddReviewBloc(addReviewUseCase: mockAddReviewUseCase);
    },
    act: (bloc) => bloc
        .add(AddReview(restoranId: 'id', userName: 'name', review: 'review')),
    expect: () => [AddReviewLoadingState(), AddReviewFailedState()],
  );

  blocTest<AddReviewBloc, AddReviewState>(
    'test add review bloc untuk AddReviewLoadingState, AddReviewNameEmptyState',
    build: () {
      AddReviewsEntity response =
          AddReviewsEntity(message: "message", error: true);
      when(mockAddReviewUseCase.addReview("id", '', 'review'))
          .thenAnswer((_) async => response);
      return AddReviewBloc(addReviewUseCase: mockAddReviewUseCase);
    },
    act: (bloc) =>
        bloc.add(AddReview(restoranId: 'id', userName: '', review: 'review')),
    expect: () => [AddReviewLoadingState(), AddReviewNameEmptyState()],
  );

  blocTest<AddReviewBloc, AddReviewState>(
    'test add review bloc untuk AddReviewLoadingState, AddReviewReviewEmptyState',
    build: () {
      AddReviewsEntity response =
          AddReviewsEntity(message: "message", error: true);
      when(mockAddReviewUseCase.addReview("id", 'name', ''))
          .thenAnswer((_) async => response);
      return AddReviewBloc(addReviewUseCase: mockAddReviewUseCase);
    },
    act: (bloc) =>
        bloc.add(AddReview(restoranId: 'id', userName: 'name', review: '')),
    expect: () => [AddReviewLoadingState(), AddReviewReviewEmptyState()],
  );
}
