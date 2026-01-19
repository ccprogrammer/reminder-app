part of 'reminder_bloc.dart';


abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final List<Reminder> reminders;

  ReminderLoaded(this.reminders);
}

class ReminderFiltered extends ReminderState {
  final List<Reminder> reminders;
  final String query;

  ReminderFiltered(this.reminders, this.query);
}
