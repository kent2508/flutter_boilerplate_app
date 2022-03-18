import 'package:flutter/widgets.dart';

class AppLoggingRoutesObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    print(
      '[Navigator] Route Pushed: '
      "(Pushed Route='${route.settings.name}', "
      "Previous Route='${previousRoute?.settings.name}'"
      ')',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    print(
      '[Navigator] Route Popped: '
      "(New Route='${previousRoute?.settings.name}', "
      "Popped Route='${route.settings.name}'"
      ')',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    print(
      '[Navigator] Route Replaced: '
      "(New Route='${newRoute?.settings.name}', "
      "Old Route='${oldRoute?.settings.name}'"
      ')',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);

    print(
      '[Navigator] Route Removed: '
      "(New Route='${previousRoute?.settings.name}', "
      "Removed Route='${route.settings.name}'"
      ')',
    );
  }
}
