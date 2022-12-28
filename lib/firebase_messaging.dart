import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oyt_front_core/logger/logger.dart';

class FirebaseMessagingUtils {
  static Future<void> requestPermissions() async {
    final res = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    Logger.log('User granted permission: ${res.authorizationStatus}');
  }
}
