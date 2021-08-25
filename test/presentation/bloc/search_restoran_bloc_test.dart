import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/usecase/search_restoran_usecase.dart';
import 'package:restoran/presentation/bloc/search_restoran_bloc/search_restoran_bloc.dart';

class MockSearchRestoranUseCase extends Mock implements SearchRestoranUseCase {}

void main() {
  SearchRestoranUseCase mockSearchRestoranUseCase;

  setUp(() {
    mockSearchRestoranUseCase = MockSearchRestoranUseCase();
  });

  blocTest<SearchRestoranBloc, SearchRestoranState>(
    'test search restoran bloc dengan parameter nama restoran '
    'dengan returning SearchRestaurantLoadingState, SearchRestaurantLoadedState',
    build: () {
      RestoranListEntity response = RestoranListEntity(
        error: false,
        message: "message",
        restorans: [
          RestoranEntity(
            id: 'id',
            name: "name",
            rating: "rating",
            pictureId: "pictureId",
            description: 'description',
            city: 'city',
          ),
        ],
      );
      when(mockSearchRestoranUseCase.searchRestoran("restaurant"))
          .thenAnswer((_) async => response);
      return SearchRestoranBloc(
          searchRestoranUseCase: mockSearchRestoranUseCase);
    },
    act: (bloc) => bloc.add(SearchRestoran(searchText: 'restaurant')),
    expect: () => [
      SearchRestoranLoadingState(),
      SearchRestoranLoadedState(
        listRestoran: [
          RestoranEntity(
            id: 'id',
            name: "name",
            rating: "rating",
            pictureId: "pictureId",
            description: 'description',
            city: 'city',
          ),
        ],
      ),
    ],
  );

  blocTest<SearchRestoranBloc, SearchRestoranState>(
    'test search restoran bloc dengan parameter nama restoran '
    'dengan returning SearchRestaurantLoadingState, SearchRestaurantFailedState',
    build: () {
      RestoranListEntity response = RestoranListEntity(
        error: true,
        message: "message",
        restorans: [
          RestoranEntity(
            id: 'id',
            name: "name",
            rating: "rating",
            pictureId: "pictureId",
            description: 'description',
            city: 'city',
          ),
        ],
      );
      when(mockSearchRestoranUseCase.searchRestoran("restaurant"))
          .thenAnswer((_) async => response);
      return SearchRestoranBloc(
          searchRestoranUseCase: mockSearchRestoranUseCase);
    },
    act: (bloc) => bloc.add(SearchRestoran(searchText: 'restaurant')),
    expect: () => [
      SearchRestoranLoadingState(),
      SearchRestoranFailedState(message: "message"),
    ],
  );
}
