import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oyt_front_core/firebase_messaging.dart';
import 'package:oyt_front_core/logger/logger.dart';

class PushNotificationProvider {
  static Future<void> setupInteractedMessage() async {
    await FirebaseMessagingUtils.requestPermissions();
    listenMessages();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    }
  }

  static void listenMessages() {
    Logger.log('Listening for messages');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger.log('Got a message whilst in the foreground!');
      Logger.log('Message data: ${message.data}');
      if (message.notification != null) {
        Logger.log('Message also contained a notification: ${message.notification}');
      }
    });
  }

  static void _handleMessage(RemoteMessage message) {
    Logger.log(message.toString());
  }
}
