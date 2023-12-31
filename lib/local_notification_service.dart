import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =        AndroidInitializationSettings('@drawable/ic_launcher');

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings
    );

    await _localNotificationService.initialize(
      settings, 
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id', 
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true
      );

    return const NotificationDetails(
      android: androidNotificationDetails,
    );
  }

  Future<void> showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload,

  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(
      id, 
      title, 
      body, 
      details,
      payload: payload
    );
  }

  Future<void> onSelectNotification(NotificationResponse? response) async {
  if (response != null) {
    final payload = response.payload;
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
  }
}
