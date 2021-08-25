import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:rxdart/rxdart.dart';

import 'navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationUtils {
  static NotificationUtils _instance;

  NotificationUtils._internal() {
    _instance = this;
  }

  factory NotificationUtils() => _instance ?? NotificationUtils._internal();
  int randomIndex = Random().nextInt(20);

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestoranListEntity restoranListEntity) async {
    var _channelId = "1";
    var _channelName = "restoran_channel";
    var _channelDescription = "restoran app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var notificationTitle = "<b>Rekomendasi restoran untukmu!</b>";
    var restoranName = restoranListEntity.restorans[randomIndex].name;

    await flutterLocalNotificationsPlugin.show(
        0, notificationTitle, restoranName, platformChannelSpecifics,
        payload: json.encode(restoranListEntity.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestoranListEntity.fromJson(json.decode(payload));
        var restoran = data.restorans[randomIndex];
        CustomNavigator.pushNamed(route, arguments: restoran);
      },
    );
  }
}
