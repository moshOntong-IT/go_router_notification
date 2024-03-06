import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_notification/src/routers/route_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onAppStart();
  }

  void onAppStart() async {
    await ref.read(routeServiceProvider).onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
        child: const SizedBox(
          height: 100,
          width: 100,
          child: Placeholder(),
        ),
      )),
    );
  }
}
