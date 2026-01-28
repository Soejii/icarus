import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app.dart';
import 'package:icarus/app/environment/app_config.dart';
import 'package:icarus/app/environment/build_environment.dart';
import 'package:icarus/firebase/firebase_init.dart';
import 'package:icarus/shared/core/infrastructure/network/config_provider.dart';
import 'package:icarus/shared/core/infrastructure/notifications/notification_routers.dart';
import 'package:icarus/shared/core/infrastructure/notifications/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initFirebase();
  await NotificationService.instance.init();
  await requestNotificationPermissionIfNeeded();
  await debugPushInfo();
  wireFcmListeners();
  await checkInitialMessage();

  const client = BuildEnv.client;
  const env = BuildEnv.env;

  final cfg = await AppConfigLoader.load(client, env);
  debugPrint('CLIENT=$client  ENV=$env  baseUrl=${cfg.baseUrl}');
  initializeDateFormatting('id_ID').then(
    (value) => runApp(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(cfg),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> requestNotificationPermissionIfNeeded() async {
  if (Platform.isAndroid) {
    final status = await Permission.notification.request();
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    log('Notification settings: ${settings.authorizationStatus}', name: 'FCM');
    // you can check status.isGranted if you want to react
  }
}

Future<void> debugPushInfo() async {
  // final info = await PackageInfo.fromPlatform();
  final token = await FirebaseMessaging.instance.getToken();
  // print('Package: ${info.packageName}');
  print('Flavor: $flavor'); // flavor comes from firebase_init.dart
  print('FCM token: $token');
}

void wireFcmListeners() {
  FirebaseMessaging.onMessage.listen((message) async {
    log(
      'FG message: '
      'title=${message.notification?.title}, '
      'body=${message.notification?.body}, '
      'data=${message.data}',
      name: 'FCM',
    );

    final fromNotification = message.notification;
    final titleFromNotif = fromNotification?.title;
    final bodyFromNotif = fromNotification?.body;

    final titleFromData = message.data['title'] as String?;
    final bodyFromData = message.data['body'] as String?;

    final title = titleFromNotif ?? titleFromData ?? 'Sidigs';
    final body = bodyFromNotif ?? bodyFromData ?? '';

    final payload = jsonEncode({
      'type': message.data['type'],
      'id': message.data['id'],
    });

    await NotificationService.instance.showSimpleNotification(
      title: title,
      body: body,
      payload: payload,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    log('Tapped notification from background, data=${message.data}',
        name: 'FCM');
    NotificationRouters.instance.handlePayloads(message.data);
  });
}

Future<void> checkInitialMessage() async {
  final initial = await FirebaseMessaging.instance.getInitialMessage();
  if (initial != null) {
    log('Launched from terminated, data=${initial.data}');
    NotificationRouters.instance.handlePayloads(initial.data);
  }
}

// Background handler must be top level and marked as entry point
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // if you need Firebase stuff here, you can call Firebase.initializeApp()
  // but for now you only log, which is fine
  log('BG message id: ${message.messageId}, data: ${message.data}');
}
