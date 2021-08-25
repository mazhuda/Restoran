import 'dart:io';
import 'package:provider/provider.dart';
import 'connectivity_provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restoran/domain/router/route_path.dart';
import 'package:restoran/external/navigation.dart';
import 'package:restoran/external/notification_utils.dart';
import 'package:restoran/presentation/screen/detail_restoran_screen/detail_restoran_screen.dart';
import 'package:restoran/presentation/screen/home_screen.dart';
import 'package:restoran/presentation/screen/search_restoran_screen.dart';
import 'package:restoran/presentation/screen/splash_screen.dart';

import 'external/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationUtils _notificationUtils = NotificationUtils();
  final BackgroundService _backgroundService = BackgroundService();
  _backgroundService.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationUtils.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: SplashScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Restoran',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigationKey,
        initialRoute: RoutePath.splash,
        routes: {
          RoutePath.splash: (context) => SplashScreen(),
          RoutePath.home: (context) => HomeScreen(),
          RoutePath.searchRestoran: (context) => SearchRestoranScreen(),
          RoutePath.restoranDetail: (context) => DetailRestoranScreen(
                restoranEntity: ModalRoute.of(context).settings.arguments,
              ),
        },
      ),
    );
  }
}
