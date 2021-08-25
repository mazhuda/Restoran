import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/domain/entity/add_review_entity.dart';
import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';

class RestoranRepositoryImpl extends RestoranRepository {
  RemoteDataSource remoteDataSource;

  RestoranRepositoryImpl({this.remoteDataSource});

  @override
  Future<RestoranListEntity> getListRestoran() async {
    List<RestoranEntity> listRestoran = [];
    var restoranData = await remoteDataSource.getRestoranList();
    restoranData.restorans.forEach((restoran) {
      var restoranEntity = RestoranEntity(
          id: restoran.id,
          name: restoran.name,
          description: restoran.description,
          pictureId: "${ApiConstant.smallImageResolution}${restoran.pictureId}",
          city: restoran.city,
          rating: restoran.rating.toString());
      listRestoran.add(restoranEntity);
    });

    var restoranListEntity = RestoranListEntity(
      error: restoranData.error,
      message: restoranData.message,
      restorans: listRestoran,
    );

    return restoranListEntity;
  }

  @override
  Future<RestoranListEntity> searchRestoran(String restoranName) async {
    List<RestoranEntity> listRestoran = [];
    listRestoran.clear();
    var restoranData = await remoteDataSource.searchRestoran(restoranName);
    restoranData.restorans.forEach((restoran) {
      var restoranEntity = RestoranEntity(
          id: restoran.id,
          name: restoran.name,
          description: restoran.description,
          pictureId: "${ApiConstant.smallImageResolution}${restoran.pictureId}",
          city: restoran.city,
          rating: restoran.rating.toString());
      listRestoran.add(restoranEntity);
    });

    var restoranListEntity = RestoranListEntity(
      error: restoranData.error,
      message: restoranData.message,
      restorans: listRestoran,
    );

    return restoranListEntity;
  }

  @override
  Future<DetailRestoranEntity> getRestoranDetail(String restoranId) async {
    var restoranData = await remoteDataSource.getRestoranDetail(restoranId);
    List<CategoryEntity> categoryList = [];
    restoranData.restoran.categories.forEach((category) {
      var categoryEntity = CategoryEntity(name: category.name);
      categoryList.add(categoryEntity);
    });

    List<FoodsEntity> foodList = [];
    restoranData.restoran.menus.foods.forEach((food) {
      var foodEntity = FoodsEntity(name: food.name);
      foodList.add(foodEntity);
    });

    List<DrinksEntity> drinkList = [];
    restoranData.restoran.menus.drinks.forEach((drink) {
      var drinkEntity = DrinksEntity(name: drink.name);
      drinkList.add(drinkEntity);
    });

    List<ConsumerReviewEntity> consumerReviewList = [];
    restoranData.restoran.consumerReviews.forEach((consumerReview) {
      var consumerReviewEntity = ConsumerReviewEntity(
          name: consumerReview.name,
          review: consumerReview.review,
          date: consumerReview.date);
      consumerReviewList.add(consumerReviewEntity);
    });

    var detailRestoranEntity = DetailRestoranEntity(
      error: restoranData.error,
      message: restoranData.message,
      id: restoranData.restoran.id,
      name: restoranData.restoran.name,
      description: restoranData.restoran.description,
      pictureId:
          "${ApiConstant.smallImageResolution}${restoranData.restoran.pictureId}",
      city: restoranData.restoran.city,
      address: restoranData.restoran.address,
      rating: restoranData.restoran.rating.toString(),
      categories: categoryList,
      menus: MenusEntity(
        foods: foodList,
        drinks: drinkList,
      ),
      consumerReviews: consumerReviewList,
    );
    return detailRestoranEntity;
  }

  @override
  Future<AddReviewsEntity> addReview(
      String restoranId, String userName, String review) async {
    var consumerReview =
        await remoteDataSource.addReview(restoranId, userName, review);
    var consumerReviewEntity = AddReviewsEntity(
        error: consumerReview.error, message: consumerReview.message);

    return consumerReviewEntity;
  }
}
