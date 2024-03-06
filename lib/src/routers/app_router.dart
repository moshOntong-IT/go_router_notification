import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_notification/src/routers/route_service.dart';
import 'package:go_router_notification/src/routers/router_util.dart';
import 'package:go_router_notification/src/routers/routers.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final appRouterProvider = Provider<AppRouter>(
  (ref) => AppRouter(
    ref,
    service: ref.read(routeServiceProvider),
  ),
);

class AppRouter {
  AppRouter(this.ref, {required this.service});
  final Ref ref;
  final RouteService service;

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: ref.read(routersProvider),
    initialLocation: AppPage.home.path,
    refreshListenable: service,
    redirect: (context, state) {
      final splashLocation = state.namedLocation(AppPage.splash.name);
      final homeLocation = state.namedLocation(AppPage.home.name);

      // final isLogin = service.isLogin;
      final isInitialized = service.isInitialized;

      final isGoingToSplash = state.matchedLocation == splashLocation;

      // final isGoingToLogin = state.matchedLocation == loginLocation;

      if (!isInitialized && !isGoingToSplash) {
        return splashLocation;
      } else if ((isInitialized && isGoingToSplash)) {
        return homeLocation;
      }
      return null;
    },
  );

  GoRouter get goRouter => router;
}
