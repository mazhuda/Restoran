import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran/connectivity_provider.dart';
import 'package:restoran/no_internet.dart';
import 'package:restoran/domain/router/route_path.dart';
import 'package:restoran/external/notification_utils.dart';
import 'package:restoran/presentation/screen/favorite_restoran/favorite_restoran_list_screen.dart';
import 'package:restoran/presentation/screen/restoran_list_screen.dart';
import 'package:restoran/presentation/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavigationIndex = 0;
  final NotificationUtils _notificationUtils = NotificationUtils();

  List<Widget> _listWidget = [
    RestoranListScreen(),
    FavoriteRestoranListScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Restoran",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorit",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Pengaturan",
    ),
  ];

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _bottomNavigationIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    _notificationUtils
        .configureSelectNotificationSubject(RoutePath.restoranDetail);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != false) {
        return model.isOnline
            ? Scaffold(
                body: _listWidget[_bottomNavigationIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _bottomNavigationIndex,
                  items: _bottomNavigationBarItems,
                  onTap: _onBottomNavigationTapped,
                ),
              )
            : NoInternet();
      }
      return Scaffold(
          body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tidak ada koneksi internet",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(27),
              child: Text(
                "Anda tidak terhubung ke internet. Pastikan Wi-Fi aktif, atau menggunakan paket data.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ));
    });
  }
}
