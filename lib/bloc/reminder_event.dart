part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadReminders extends ReminderEvent {}

class AddReminder extends ReminderEvent {
  final Reminder reminder;
  AddReminder(this.reminder);
}

class UpdateReminder extends ReminderEvent {
  final Reminder reminder;
  UpdateReminder(this.reminder);
}

class DeleteReminder extends ReminderEvent {
  final String id;
  DeleteReminder(this.id);
}
