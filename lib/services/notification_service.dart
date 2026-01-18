import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../models/reminder.dart';

class NotificationService {
  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'reminder_channel',
          channelName: 'Reminders',
          channelDescription: 'Reminder notifications',
          importance: NotificationImportance.Max,
        ),
      ],
    );

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
            .requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> scheduleNotification(Reminder reminder) async {
    log("Scheduling notification: ${reminder.title}");

    final now = DateTime.now();

    DateTime baseTime = DateTime(
      now.year,
      now.month,
      now.day,
      reminder.time.hour,
      reminder.time.minute,
    );

    if (baseTime.isBefore(now)) {
      baseTime = baseTime.add(const Duration(days: 1));
    }

    NotificationSchedule? schedule;

    switch (reminder.recurrence) {
      case RecurrenceType.none:
        schedule = NotificationCalendar.fromDate(date: baseTime);
        break;

      case RecurrenceType.daily:
        schedule = NotificationCalendar(
          hour: reminder.time.hour,
          minute: reminder.time.minute,
          second: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.weekly:
        schedule = NotificationCalendar(
          hour: reminder.time.hour,
          minute: reminder.time.minute,
          weekday: reminder.recurrenceWeekday,
          second: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.monthly:
        schedule = NotificationCalendar(
          hour: reminder.time.hour,
          minute: reminder.time.minute,
          day: reminder.recurrenceDayOfMonth,
          second: 0,
          repeats: true,
        );
        break;
    }

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder.id.hashCode,
        channelKey: 'reminder_channel',
        title: "Reminder",
        body: reminder.title,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: schedule,
    );

    log("Notification scheduled successfully");
  }

  static Future<void> cancelNotification(String id) async {
    await AwesomeNotifications().cancel(id.hashCode);
  }

  static Future<void> showDummyNotification() async {
    log("Showing dummy notification");

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'reminder_channel',
        title: "Test Notification",
        body: "This is a dummy notification",
        notificationLayout: NotificationLayout.Default,
      ),
    );

    log("Dummy notification shown");
  }
}
