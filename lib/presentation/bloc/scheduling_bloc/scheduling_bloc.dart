import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:restoran/external/background_service.dart';
import 'package:restoran/external/date_helper.dart';
import 'package:restoran/external/restoran_shared_pref.dart';

part 'scheduling_event.dart';

part 'scheduling_state.dart';

class SchedulingBloc extends Bloc<SchedulingEvent, SchedulingState> {
  RestoranSharePreferences restoranSharePreferences;

  SchedulingBloc({this.restoranSharePreferences})
      : super(SchedulingInitialState());

  @override
  Stream<SchedulingState> mapEventToState(SchedulingEvent event) async* {
    if (event is CheckScheduling) {
      yield SchedulingLoadingState();
      bool value = await restoranSharePreferences.getAlarmValue();
      if (value == true) {
        yield SchedulingSetAlarmState();
      } else {
        yield SchedulingCancelAlarmState();
      }
    } else if (event is SetScheduling) {
      yield SchedulingLoadingState();
      await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateHelper.format(),
        exact: true,
        wakeup: true,
      );
      await restoranSharePreferences.saveAlarm(true);
      yield SchedulingSetAlarmState();
    } else if (event is CancelScheduling) {
      yield SchedulingLoadingState();
      await AndroidAlarmManager.cancel(1);
      await restoranSharePreferences.saveAlarm(false);
      yield SchedulingCancelAlarmState();
    }
  }
}
