import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../models/reminder.dart';

class NotificationService {
  static Future<void> init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Reminders',
        channelDescription: 'Notification channel for reminders',
        importance: NotificationImportance.Max,
        defaultColor: const Color(0xFF9D50DD),
        ledColor: const Color(0xFF9D50DD),
      ),
    ]);

    await AwesomeNotifications().isNotificationAllowed().then((allowed) {
      if (!allowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> scheduleNotification(Reminder reminder) async {
    await cancelNotification(reminder.id.hashCode);

    NotificationCalendar schedule;

    final time = reminder.time;

    switch (reminder.recurrence) {
      case RecurrenceType.daily:
        schedule = NotificationCalendar(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.weekly:
        schedule = NotificationCalendar(
          weekday: reminder.weekday,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.monthly:
        schedule = NotificationCalendar(
          day: time.day,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        );
        break;

      default:
        schedule = NotificationCalendar(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          millisecond: 0,
          repeats: false,
        );
    }

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder.id.hashCode,
        channelKey: 'reminder_channel',
        title: reminder.title,
        body: reminder.note.isNotEmpty ? reminder.note : "It's time!",
        notificationLayout: NotificationLayout.Default,
        payload: {
          "id": reminder.id,
          "title": reminder.title,
          "note": reminder.note,
        },
      ),
      schedule: schedule,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> cancelAll() async {
    await AwesomeNotifications().cancelAll();
  }

  static Future<void> showDummyNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'reminder_channel',
        title: "Test Notification",
        body: "This is a test reminder notification",
      ),
    );
  }

  static Future<void> listenForActions(
    Function(Reminder) onReminderTapped,
  ) async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {
        final payload = receivedAction.payload;

        if (payload != null) {
          final reminder = Reminder(
            id: payload["id"] ?? "",
            title: payload["title"] ?? "",
            note: payload["note"] ?? "",
            time: DateTime.now(),
            recurrence: RecurrenceType.none,
          );

          onReminderTapped(reminder);
        }
      },
    );
  }
}
