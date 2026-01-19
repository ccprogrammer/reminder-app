# Reminder App

A simple Flutter reminder application that allows users to create tasks and receive scheduled notifications with different recurrence options.

---

## Features

- Create reminders with title, note, and time  
- View list of today's tasks  
- Delete reminders  
- Open reminder details  
- Local notifications using **Awesome Notifications**  
- Recurring reminders:
  - One-time  
  - Daily  
  - Weekly  
  - Monthly  
  - Yearly  

---

## Tech Stack

- **Flutter**
- **Bloc State Management**
- **Awesome Notifications**
- Clean UI with reusable widgets

---

## Notification Scheduling Logic

Notifications are scheduled using `AwesomeNotifications` with proper recurrence mapping.

Each recurrence type is converted to a specific `NotificationCalendar` configuration:

| Recurrence Type | Behavior |
|----------------|---------|
| none | Trigger once at selected time |
| daily | Repeat every day at the same hour and minute |
| weekly | Repeat every week on the same weekday |
| monthly | Repeat every month on the same day |
| yearly | Repeat every year on the same month and day |

Example scheduling implementation:

```dart
switch (reminder.recurrence) {
  case RecurrenceType.daily:
    NotificationCalendar(
      hour: time.hour,
      minute: time.minute,
      repeats: true,
    );
    break;

  case RecurrenceType.weekly:
    NotificationCalendar(
      weekday: time.weekday,
      hour: time.hour,
      minute: time.minute,
      repeats: true,
    );
    break;

  // etc...
}
```
