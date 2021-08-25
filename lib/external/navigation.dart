import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static pushNamed(String routeName, {@required Object arguments}) {
    navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  static pushReplacementNamed(String routeName, {@required Object arguments}) {
    navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static pop() => navigationKey.currentState.pop();
}
