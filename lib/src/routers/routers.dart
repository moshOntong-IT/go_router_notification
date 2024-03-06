import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_notification/src/features/landing/presentation/home_screen.dart';
import 'package:go_router_notification/src/features/landing/presentation/tab_screen.dart';
import 'package:go_router_notification/src/features/login/presentation/login_screen.dart';
import 'package:go_router_notification/src/features/splash/presentation/splash_screen.dart';
import 'package:go_router_notification/src/routers/route_service.dart';
import 'package:go_router_notification/src/routers/router_util.dart';

final routersProvider = Provider<List<GoRoute>>((ref) {
  final service = ref.read(routeServiceProvider);
  return [
    GoRoute(
      path: "/",
      redirect: (_, __) => AppPage.home.path,
    ),
    GoRoute(
        path: AppPage.splash.path,
        name: AppPage.splash.name,
        builder: (context, state) => const SplashScreen()),
    GoRoute(
        path: AppPage.login.path,
        name: AppPage.login.name,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: AppPage.home.path,
        name: AppPage.home.name,
        redirect: (context, state) {
          final isLogin = service.isLogin;
          if (!isLogin) return AppPage.login.path;
          return null;
        },
        builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: AppPage.tab.path,
        name: AppPage.tab.name,
        builder: (context, state) {
          final tab = state.uri.queryParameters['tab'] ?? '0';
          return TabScreen(tab: int.parse(tab));
        }),
  ];
});
