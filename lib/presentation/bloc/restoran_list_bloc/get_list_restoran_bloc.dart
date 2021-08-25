import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/usecase/get_list_restoran_usecase.dart';

part 'get_list_restoran_event.dart';

part 'get_list_restoran_state.dart';

class GetListRestoranBloc
    extends Bloc<GetListRestoranEvent, GetListRestoranState> {
  GetListRestoranUseCase getListRestoranUseCase;

  GetListRestoranBloc({this.getListRestoranUseCase})
      : super(GetListRestoranInitialState());

  @override
  Stream<GetListRestoranState> mapEventToState(
      GetListRestoranEvent event) async* {
    if (event is GetListRestoran) {
      yield GetListRestoranLoadingState();
      var listRestoran = await getListRestoranUseCase.getListRestoran();
      if (listRestoran.error != true) {
        yield GetListRestoranLoadedState(listRestoran: listRestoran.restorans);
      } else {
        yield GetListRestoranFailedState(message: listRestoran.message);
      }
    }
  }
}
