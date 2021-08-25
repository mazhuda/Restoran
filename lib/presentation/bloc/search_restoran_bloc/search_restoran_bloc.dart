import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/usecase/search_restoran_usecase.dart';

part 'search_restoran_event.dart';

part 'search_restoran_state.dart';

class SearchRestoranBloc
    extends Bloc<SearchRestoranEvent, SearchRestoranState> {
  SearchRestoranUseCase searchRestoranUseCase;

  SearchRestoranBloc({this.searchRestoranUseCase})
      : super(SearchRestoranInitialState());

  @override
  Stream<SearchRestoranState> mapEventToState(
      SearchRestoranEvent event) async* {
    if (event is SearchRestoran) {
      yield SearchRestoranLoadingState();
      var listRestoran =
          await searchRestoranUseCase.searchRestoran(event.searchText);
      if (listRestoran.error != true) {
        yield SearchRestoranLoadedState(listRestoran: listRestoran.restorans);
      } else {
        yield SearchRestoranFailedState(message: listRestoran.message);
      }
    }
  }
}
