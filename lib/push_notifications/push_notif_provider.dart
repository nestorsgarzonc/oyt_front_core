import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oyt_front_core/firebase_messaging.dart';
import 'package:oyt_front_core/logger/logger.dart';

class PushNotificationProvider {
  static Future<void> setupInteractedMessage() async {
    await FirebaseMessagingUtils.requestPermissions();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    }
  }

  static void _handleMessage(RemoteMessage message) {
    Logger.log(message.toString());
  }
}
