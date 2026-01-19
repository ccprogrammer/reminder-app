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
        )
      ],
    );

    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> scheduleNotification(Reminder reminder) async {

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
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: "OPEN",
          label: "Open",
        ),
      ],
      schedule: NotificationCalendar.fromDate(
        date: reminder.time,
        repeats: reminder.recurrence != RecurrenceType.none,
      ),
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
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: "OPEN",
          label: "Open",
        ),
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
