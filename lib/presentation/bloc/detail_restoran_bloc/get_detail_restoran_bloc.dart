import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/usecase/get_restoran_detail_usecase.dart';

part 'get_detail_restoran_event.dart';

part 'get_detail_restoran_state.dart';

class GetDetailRestoranBloc
    extends Bloc<GetDetailRestoranEvent, GetDetailRestoranState> {
  GetRestoranDetailUseCase getRestoranDetailUseCase;

  GetDetailRestoranBloc({this.getRestoranDetailUseCase})
      : super(GetDetailRestoranInitialState());

  @override
  Stream<GetDetailRestoranState> mapEventToState(
      GetDetailRestoranEvent event) async* {
    if (event is GetDetailRestoran) {
      yield GetDetailRestoranLoadingState();
      var detailRestoran =
          await getRestoranDetailUseCase.getRestoranDetail(event.restoranId);
      if (detailRestoran.error != true) {
        yield GetDetailRestoranLoadedState(detailRestoran: detailRestoran);
      } else {
        yield GetDetailRestoranFailedState(message: detailRestoran.message);
      }
    }
  }
}
