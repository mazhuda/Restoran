import 'package:restoran/domain/entity/add_review_entity.dart';
import 'package:restoran/domain/repository/restoran_repo.dart';

abstract class AddReviewUseCase {
  Future<AddReviewsEntity> addReview(
      String restoranId, String userName, String review);
}

class AddReviewUseCaseImpl extends AddReviewUseCase {
  RestoranRepository restoranRepository;

  AddReviewUseCaseImpl({this.restoranRepository});

  @override
  Future<AddReviewsEntity> addReview(
          String restoranId, String userName, String review) =>
      restoranRepository.addReview(restoranId, userName, review);
}
