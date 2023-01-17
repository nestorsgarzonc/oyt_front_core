import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_core/constants/firebase_constants.dart';
import 'package:oyt_front_core/firebase_messaging.dart';
import 'package:oyt_front_core/logger/logger.dart';

final pushNotificationsProvider = Provider<PushNotificationProvider>((ref) {
  return PushNotificationProvider();
});

class PushNotificationProvider {
  PushNotificationProvider();

  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  MaterialBanner showMaterialBanner(RemoteMessage message, void Function() onHide) {
    return MaterialBanner(
      leading: const Icon(Icons.info_outline, color: Colors.deepOrange),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.notification?.title ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(message.notification?.body ?? ''),
        ],
      ),
      actions: [
        TextButton(onPressed: onHide, child: const Text('OK')),
      ],
    );
  }

  Future<void> setupInteractedMessage() async {
    await Future.wait([
      FirebaseMessagingUtils.requestPermissions(),
      FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true),
    ]);
    try {
      await FirebaseMessaging.instance
          .getToken(vapidKey: kIsWeb ? FirebaseConstants.vapidKey : null);
    } catch (e, s) {
      Logger.logError('Error getting FCM token $e', s);
    }
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    listenMessages();
    if (initialMessage != null) {
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    }
  }

  Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance
          .getToken(vapidKey: FirebaseConstants.vapidKey)
          .timeout(const Duration(seconds: 2), onTimeout: () => null);
    } catch (e, s) {
      Logger.logError('Error getting FCM token $e', s);
      return null;
    }
  }

  void listenMessages() {
    Logger.log('Listening for messages');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger.log('Got a message whilst in the foreground!');
      Logger.log('Message data: ${message.data}');
      if (message.notification != null) {
        Logger.log('Message also contained a notification: ${message.notification}');
        messengerKey.currentState?.showMaterialBanner(
          showMaterialBanner(message, () => messengerKey.currentState?.hideCurrentMaterialBanner()),
        );
      }
    });
  }

  //  onMessageWebNotification(String message) {
  //   html.window.navigator.serviceWorker.ready.then((registration) {
  //     var notificationTitle = notificationData.title;
  //     var notificationOptions = {'body': notificationData.body, 'data': notificationData};
  //     registration.showNotification(
  //       notificationTitle,
  //       notificationOptions,
  //     );
  //   });
  // }

  void _handleMessage(RemoteMessage message) {
    Logger.log(message.toString());
  }
}
