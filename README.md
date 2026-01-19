# Reminder App

A simple Flutter reminder application that allows users to create, edit, delete, search, and receive scheduled notifications for tasks.

---

## Features

- Create, update, and delete reminders  
- Schedule local notifications  
- Support for recurrence (daily, weekly, monthly, yearly)  
- Search reminders by title or note  
- Open reminder detail directly from notification  
- Clean UI with BLoC state management  

---

## Setup Instructions

### Prerequisites

Make sure you have the following installed:

- Flutter SDK (latest stable)
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. Clone the repository:
     git clone <repository_url>
     cd reminder_app

2. Install dependencies:
     flutter pub get

3. Run the app:
     flutter run


---

## Dependencies / Plugins Used

| Package | Purpose |
|-------|---------|
| flutter_bloc | State management using BLoC pattern |
| awesome_notifications | Scheduling and handling local notifications |
| intl | Date and time formatting |
| cupertino_icons | iOS style icons |

All dependencies are defined in pubspec.yaml.

---

## Architectural Notes

This app follows a clean BLoC Architecture with clear separation of concerns.

### Core Structure

```
lib/
├── bloc/
│ ├── reminder_bloc.dart
│ ├── reminder_event.dart
│ └── reminder_state.dart
├── models/
│ └── reminder.dart
├── repository/
│ └── reminder_repository.dart
├── services/
│ └── notification_service.dart
├── screens/
│ ├── add_edit_screen.dart
│ ├── reminder_detail_screen.dart
│ └── home_screen.dart
└── widgets/
```


### BLoC Structure

- UI dispatches events such as:
  - LoadReminders
  - AddReminder
  - UpdateReminder
  - DeleteReminder
  - SearchReminder

- ReminderBloc processes events and emits states:
  - ReminderInitial
  - ReminderLoaded
  - ReminderFiltered

- Repository handles data operations  
- NotificationService manages scheduling and opening reminders  

This structure keeps the code modular, testable, and easy to maintain.

---

## Assumptions / Limitations

- Reminders are stored locally (no backend or database)
- Notifications rely on device local time
- Recurring reminders only support simple patterns
- Search is basic (title and note matching only)
- No cloud sync or multi-device support

---

## Bonus Features

- Tap notification to open reminder detail screen  
- Live search filtering using BLoC  
- Editable reminders  
- Delete directly from list or detail screen  
- Sorted reminders by time  
- Clean modern UI  

---

## How Recurrence Works

Recurrence types supported:

- none  
- daily  
- weekly  
- monthly  
- yearly  

The app schedules notifications using AwesomeNotifications with proper calendar rules based on the selected recurrence type.

---

## Notes

This project demonstrates:

- Proper use of BLoC state management  
- Local notification scheduling  
- Modular Flutter architecture  
- Clean UI implementation  

---
Made by ccprogrammer.


