import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oyt_front_core/logger/logger.dart';

final pushNotificationProvider = Provider<PushNotificationProvider>((ref) {
  return PushNotificationProvider();
});

class PushNotificationProvider {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    Logger.log(message.toString());
  }
}
