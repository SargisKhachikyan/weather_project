import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings: settings);
  }

  Future<void> showTestNotification() async {
    const details = NotificationDetails(
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      id: 1,
      title: 'Weather',
      body: 'Test notification is working!',
      notificationDetails: details,
    );
  }
}
