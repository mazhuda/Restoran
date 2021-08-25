import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/usecase/get_restoran_detail_usecase.dart';
import 'package:restoran/presentation/bloc/detail_restoran_bloc/get_detail_restoran_bloc.dart';

class MockGetRestoranDetailUseCase extends Mock
    implements GetRestoranDetailUseCase {}

void main() {
  GetRestoranDetailUseCase mockGetRestoranDetailUseCase;

  setUp(() {
    mockGetRestoranDetailUseCase = MockGetRestoranDetailUseCase();
  });

  blocTest<GetDetailRestoranBloc, GetDetailRestoranState>(
    'test get detail restoran bloc dengan parameter id'
    'untuk returning GetDetailRestaurantLoadingState, GetDetailRestaurantLoadedState ',
    build: () {
      DetailRestoranEntity response = DetailRestoranEntity(
          error: false,
          message: "message",
          address: "address",
          name: "name",
          rating: "rating",
          pictureId: "pictureId",
          menus: MenusEntity(foods: [
            FoodsEntity(
              name: 'name',
            )
          ], drinks: [
            DrinksEntity(
              name: 'name',
            )
          ]),
          categories: [
            CategoryEntity(name: "name"),
          ],
          consumerReviews: [
            ConsumerReviewEntity(name: 'name'),
          ]);
      when(mockGetRestoranDetailUseCase.getRestoranDetail("id"))
          .thenAnswer((_) async => response);
      return GetDetailRestoranBloc(
          getRestoranDetailUseCase: mockGetRestoranDetailUseCase);
    },
    act: (bloc) => bloc.add(GetDetailRestoran(restoranId: 'id')),
    expect: () => [
      GetDetailRestoranLoadingState(),
      GetDetailRestoranLoadedState(
          detailRestoran: DetailRestoranEntity(
              error: false,
              message: "message",
              address: "address",
              name: "name",
              rating: "rating",
              pictureId: "pictureId",
              menus: MenusEntity(foods: [
                FoodsEntity(
                  name: 'name',
                )
              ], drinks: [
                DrinksEntity(
                  name: 'name',
                )
              ]),
              categories: [
            CategoryEntity(name: "name"),
          ],
              consumerReviews: [
            ConsumerReviewEntity(name: 'name'),
          ]))
    ],
  );

  blocTest<GetDetailRestoranBloc, GetDetailRestoranState>(
    'test get detail restoran bloc dengan parameter id'
    'untuk returning GetDetailRestaurantLoadingState, GetDetailRestaurantFailedState',
    build: () {
      DetailRestoranEntity response = DetailRestoranEntity(
          error: true,
          message: "message",
          address: "address",
          name: "name",
          rating: "rating",
          pictureId: "pictureId",
          menus: MenusEntity(foods: [
            FoodsEntity(
              name: 'name',
            )
          ], drinks: [
            DrinksEntity(
              name: 'name',
            )
          ]),
          categories: [
            CategoryEntity(name: "name"),
          ],
          consumerReviews: [
            ConsumerReviewEntity(name: 'name'),
          ]);
      when(mockGetRestoranDetailUseCase.getRestoranDetail("id"))
          .thenAnswer((_) async => response);
      return GetDetailRestoranBloc(
          getRestoranDetailUseCase: mockGetRestoranDetailUseCase);
    },
    act: (bloc) => bloc.add(GetDetailRestoran(restoranId: 'id')),
    expect: () => [
      GetDetailRestoranLoadingState(),
      GetDetailRestoranFailedState(message: "message"),
    ],
  );
}
