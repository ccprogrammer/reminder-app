part of 'reminder_bloc.dart';

abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final List<Reminder> reminders;
  ReminderLoaded(this.reminders);
}
