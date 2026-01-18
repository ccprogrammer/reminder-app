import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/reminder.dart';
import '../repository/reminder_repository.dart';
import '../services/notification_service.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository repository;

  ReminderBloc(this.repository) : super(ReminderInitial()) {
    on<LoadReminders>(_onLoadReminders);
    on<AddReminder>(_onAddReminder);
    on<UpdateReminder>(_onUpdateReminder);
    on<DeleteReminder>(_onDeleteReminder);
  }

  Future<void> _onLoadReminders(
    LoadReminders event,
    Emitter<ReminderState> emit,
  ) async {
    final reminders = await repository.getReminders();
    emit(ReminderLoaded(reminders));
  }

  Future<void> _onAddReminder(
    AddReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await repository.addReminder(event.reminder);

    await NotificationService.scheduleNotification(event.reminder);

    final reminders = await repository.getReminders();
    emit(ReminderLoaded(reminders));
  }

  Future<void> _onUpdateReminder(
    UpdateReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await repository.updateReminder(event.reminder);

    // Cancel old and reschedule
    await NotificationService.cancelNotification(event.reminder.id.hashCode);

    await NotificationService.scheduleNotification(event.reminder);

    final reminders = await repository.getReminders();
    emit(ReminderLoaded(reminders));
  }

  Future<void> _onDeleteReminder(
    DeleteReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await repository.deleteReminder(event.id);

    await NotificationService.cancelNotification(event.id.hashCode);

    final reminders = await repository.getReminders();
    emit(ReminderLoaded(reminders));
  }
}
