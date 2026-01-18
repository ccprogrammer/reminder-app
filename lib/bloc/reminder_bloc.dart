import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/reminder.dart';
import '../repository/reminder_repository.dart';
import '../services/notification_service.dart';
part 'reminder_event.dart';
part 'reminder_state.dart';





class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository repository;

  ReminderBloc(this.repository) : super(ReminderInitial()) {
    on<LoadReminders>(_onLoad);
    on<AddReminder>(_onAdd);
    on<UpdateReminder>(_onUpdate);
    on<DeleteReminder>(_onDelete);
  }

  Future<void> _onLoad(
      LoadReminders event, Emitter<ReminderState> emit) async {
    final reminders = await repository.getReminders();
    emit(ReminderLoaded(reminders));
  }

  Future<void> _onAdd(
      AddReminder event, Emitter<ReminderState> emit) async {
    await repository.addReminder(event.reminder);
    await NotificationService.scheduleNotification(event.reminder);

    emit(ReminderLoaded(await repository.getReminders()));
  }

  Future<void> _onUpdate(
      UpdateReminder event, Emitter<ReminderState> emit) async {
    await NotificationService.cancelNotification(event.reminder.id);
    await repository.updateReminder(event.reminder);
    await NotificationService.scheduleNotification(event.reminder);

    emit(ReminderLoaded(await repository.getReminders()));
  }

  Future<void> _onDelete(
      DeleteReminder event, Emitter<ReminderState> emit) async {
    await repository.deleteReminder(event.id);
    await NotificationService.cancelNotification(event.id);

    emit(ReminderLoaded(await repository.getReminders()));
  }
}
