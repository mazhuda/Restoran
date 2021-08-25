import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/usecase/get_list_restoran_usecase.dart';
import 'package:restoran/presentation/bloc/restoran_list_bloc/get_list_restoran_bloc.dart';

class MockGetListRestoranUseCase extends Mock
    implements GetListRestoranUseCase {}

void main() {
  GetListRestoranUseCase mockGetListRestoranUseCase;

  setUp(() {
    mockGetListRestoranUseCase = MockGetListRestoranUseCase();
  });

  blocTest<GetListRestoranBloc, GetListRestoranState>(
    'test get list restoran bloc berkaitan dengan list restoran '
    'mempunyai returning GetListRestaurantLoadingState, GetListRestaurantLoadedState',
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
      when(mockGetListRestoranUseCase.getListRestoran())
          .thenAnswer((_) async => response);
      return GetListRestoranBloc(
          getListRestoranUseCase: mockGetListRestoranUseCase);
    },
    act: (bloc) => bloc.add(GetListRestoran()),
    expect: () => [
      GetListRestoranLoadingState(),
      GetListRestoranLoadedState(
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

  blocTest<GetListRestoranBloc, GetListRestoranState>(
    'test get list restoran bloc berkaitan dengan list restoran '
    'mempunyai returning GetListRestaurantLoadingState, GetListRestaurantFailedState',
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
      when(mockGetListRestoranUseCase.getListRestoran())
          .thenAnswer((_) async => response);
      return GetListRestoranBloc(
          getListRestoranUseCase: mockGetListRestoranUseCase);
    },
    act: (bloc) => bloc.add(GetListRestoran()),
    expect: () => [
      GetListRestoranLoadingState(),
      GetListRestoranFailedState(message: "message"),
    ],
  );
}
