import 'dart:isolate';

import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/data/remote/repository/restoran_repo_impl.dart';
import 'package:restoran/domain/usecase/get_list_restoran_usecase.dart';
import 'package:restoran/external/notification_utils.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationUtils _notificationUtils = NotificationUtils();
    var result = await GetListRestoranUseCaseImpl(
      restoranRepository: RestoranRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(
          dio: Dio(
            BaseOptions(
              baseUrl: ApiConstant.baseUrl,
            ),
          ),
        ),
      ),
    ).getListRestoran();
    await _notificationUtils.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
