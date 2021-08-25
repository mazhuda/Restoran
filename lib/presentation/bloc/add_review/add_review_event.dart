part of 'add_review_bloc.dart';

abstract class AddReviewEvent extends Equatable {
  const AddReviewEvent();
}

class AddReview extends AddReviewEvent {
  final String restoranId;
  final String userName;
  final String review;

  AddReview({this.restoranId, this.userName, this.review});

  @override
  List<Object> get props => [restoranId, userName, review];
}
