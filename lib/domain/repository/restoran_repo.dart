import 'package:restoran/domain/entity/add_review_entity.dart';
import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';

abstract class RestoranRepository {
  Future<RestoranListEntity> getListRestoran();
  Future<DetailRestoranEntity> getRestoranDetail(String restoranId);
  Future<RestoranListEntity> searchRestoran(String restoranName);
  Future<AddReviewsEntity> addReview(
      String restoranId, String userName, String review);
}
