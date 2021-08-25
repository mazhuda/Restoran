import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restoran/domain/usecase/add_review_usecase.dart';

part 'add_review_event.dart';

part 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  AddReviewUseCase addReviewUseCase;

  AddReviewBloc({this.addReviewUseCase}) : super(AddReviewInitialState());

  @override
  Stream<AddReviewState> mapEventToState(AddReviewEvent event) async* {
    if (event is AddReview) {
      yield AddReviewLoadingState();
      if (event.userName.isNotEmpty && event.review.isNotEmpty) {
        var listRestoran = await addReviewUseCase.addReview(
            event.restoranId, event.userName, event.review);
        if (listRestoran.error != true) {
          yield AddReviewSuccessState();
        } else {
          yield AddReviewFailedState();
        }
      } else if (event.userName.isEmpty) {
        yield AddReviewNameEmptyState();
      } else if (event.review.isEmpty) {
        yield AddReviewReviewEmptyState();
      }
    }
  }
}
