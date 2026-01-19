import 'package:awesome_notifications/awesome_notifications.dart';

import '../models/reminder.dart';

class NotificationService {
  static Future<void> init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Reminders',
        channelDescription: 'Reminder notifications',
        importance: NotificationImportance.Max,
      ),
    ]);

    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> scheduleNotification(Reminder reminder) async {
    NotificationSchedule? schedule;

    final time = reminder.time;

    switch (reminder.recurrence) {
      case RecurrenceType.none:
        schedule = NotificationCalendar.fromDate(
          date: time,
          repeats: false,
        );
        break;

      case RecurrenceType.daily:
        schedule = NotificationCalendar(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.weekly:
        schedule = NotificationCalendar(
          weekday: time.weekday,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.monthly:
        schedule = NotificationCalendar(
          day: time.day,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          repeats: true,
        );
        break;

      case RecurrenceType.yearly:
        schedule = NotificationCalendar(
          month: time.month,
          day: time.day,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          repeats: true,
        );
        break;
    }

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder.id.hashCode,
        channelKey: 'reminder_channel',
        title: reminder.title,
        body: reminder.note.isNotEmpty
            ? reminder.note
            : "Reminder time!",
        payload: {
          "id": reminder.id,
          "title": reminder.title,
          "note": reminder.note,
          "time": reminder.time.toIso8601String(),
          "recurrence": reminder.recurrence.name,
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: "OPEN",
          label: "Open",
        ),
      ],
      schedule: schedule,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> showDummyNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 999,
        channelKey: 'reminder_channel',
        title: "Test Reminder",
        body: "Tap to open detail screen",
        payload: {
          "id": "dummy",
          "title": "Test Reminder",
          "note": "This is a dummy notification",
          "time": DateTime.now().toIso8601String(),
          "recurrence": RecurrenceType.none.name,
        },
      ),
      actionButtons: [
        NotificationActionButton(key: "OPEN", label: "Open")
      ],
    );
  }

  static Future<void> listenForActions(
    Function(Reminder) onReminderTapped,
  ) async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {
        final payload = receivedAction.payload;

        if (payload != null) {
          final String id = payload["id"] ?? "";
          final String title = payload["title"] ?? "";
          final String note = payload["note"] ?? "";

          final String? timeString = payload["time"];
          final DateTime time = timeString != null
              ? DateTime.parse(timeString)
              : DateTime.now();

          final String? recurrenceString = payload["recurrence"];

          RecurrenceType recurrence = RecurrenceType.none;

          if (recurrenceString != null) {
            recurrence = RecurrenceType.values.firstWhere(
              (e) => e.name == recurrenceString,
              orElse: () => RecurrenceType.none,
            );
          }

          final reminder = Reminder(
            id: id,
            title: title,
            note: note,
            time: time,
            recurrence: recurrence,
          );

          onReminderTapped(reminder);
        }
      },
    );
  }
}
