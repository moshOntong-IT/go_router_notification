import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_notification/src/core/local_notification_service.dart';
import 'package:go_router_notification/src/routers/router_util.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  StreamSubscription<Map<String, dynamic>>? _notificationSubscription;

  @override
  void initState() {
    super.initState();

    _notificationSubscription = ref
        .read(localNotificationServiceProvider)
        .onNotificationStream
        .listen(onNotificationListener);
  }

  void onNotificationListener(Map<String, dynamic> payload) {
    context.pushNamed(
      AppPage.tab.name,
      queryParameters: payload,
    );
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.pushNamed(
                AppPage.tab.name,
                queryParameters: {'tab': '1'},
              );
            },
            child: const Text('Proceed to Tab Screen'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(localNotificationServiceProvider).showNotification(
                    id: 11212,
                    title: 'Simple Notification',
                    body: 'This is a simple notification',
                  );
            },
            child: const Text('Simple Notification'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(localNotificationServiceProvider)
                  .showNotificationTimerPayload(
                    id: 11212,
                    title: 'Timer Notification',
                    body: 'This is a timer notification with payload',
                    seconds: 5,
                    payload: jsonEncode({'tab': '0'}),
                  );
            },
            child: const Text('Timer Notification with Payload'),
          ),
        ],
      ),
    ));
  }
}
