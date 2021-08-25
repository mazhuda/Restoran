part of 'get_detail_restoran_bloc.dart';

abstract class GetDetailRestoranEvent extends Equatable {
  const GetDetailRestoranEvent();
}

class GetDetailRestoran extends GetDetailRestoranEvent {
  final String restoranId;

  GetDetailRestoran({this.restoranId});

  @override
  List<Object> get props => [restoranId];
}
