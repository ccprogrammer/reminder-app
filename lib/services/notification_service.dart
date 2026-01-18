import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/reminder.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _notifications.initialize(settings);
  }

  static Future<void> scheduleNotification(Reminder reminder) async {
    bool allowed = await requestExactAlarmPermission();

    if (!allowed) {
      log("Exact alarm permission not granted");
      return;
    }

    final scheduledTime = tz.TZDateTime.from(reminder.time, tz.local);

    await _notifications.zonedSchedule(
      reminder.id.hashCode,
      "Reminder",
      reminder.title,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future<bool> requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isGranted) {
      return true;
    }

    final status = await Permission.scheduleExactAlarm.request();
    return status.isGranted;
  }
}
