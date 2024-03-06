import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_notification/src/routers/router_util.dart';
import 'package:go_router_notification/src/routers/app_router.dart';

final routeServiceProvider =
    ChangeNotifierProvider<RouteService>((ref) => RouteService(ref));

class RouteService extends ChangeNotifier {
  RouteService(this.ref);

  final Ref ref;

  bool _isLogin = false;
  bool _isInitialized = false;

  bool get isLogin => _isLogin;
  bool get isInitialized => _isInitialized;

  set login(bool isLogin) {
    _isLogin = isLogin;

    ref.read(appRouterProvider).router.go(AppPage.home.fullPath);
    notifyListeners();
  }

  set initialized(bool isInitialized) {
    _isInitialized = isInitialized;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    // await ref.read(localNotificationServiceProvider).initialize();
    await getLoginStatus();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> getLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    _isLogin = false;
  }
}
