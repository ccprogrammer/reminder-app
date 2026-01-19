import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/reminder.dart';
import '../repository/reminder_repository.dart';
import '../services/notification_service.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository repository;

  List<Reminder> _allReminders = [];

  ReminderBloc(this.repository) : super(ReminderInitial()) {
    on<LoadReminders>(_onLoadReminders);
    on<AddReminder>(_onAddReminder);
    on<UpdateReminder>(_onUpdateReminder);
    on<DeleteReminder>(_onDeleteReminder);
    on<SearchReminders>(_onSearchReminders);
  }

  Future<void> _onLoadReminders(
    LoadReminders event,
    Emitter<ReminderState> emit,
  ) async {
    _allReminders = await repository.getReminders();
    emit(ReminderLoaded(_allReminders));
  }

  Future<void> _onAddReminder(
    AddReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await repository.addReminder(event.reminder);

    await NotificationService.scheduleNotification(event.reminder);

    _allReminders = await repository.getReminders();
    emit(ReminderLoaded(_allReminders));
  }

  Future<void> _onUpdateReminder(
    UpdateReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await repository.updateReminder(event.reminder);

    await NotificationService.cancelNotification(event.reminder.id.hashCode);

    await NotificationService.scheduleNotification(event.reminder);

    _allReminders = await repository.getReminders();
    emit(ReminderLoaded(_allReminders));
  }

  Future<void> _onDeleteReminder(
    DeleteReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await repository.deleteReminder(event.id);

    await NotificationService.cancelNotification(event.id.hashCode);

    _allReminders = await repository.getReminders();
    emit(ReminderLoaded(_allReminders));
  }

  Future<void> _onSearchReminders(
    SearchReminders event,
    Emitter<ReminderState> emit,
  ) async {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(ReminderLoaded(_allReminders));
      return;
    }

    final filtered = _allReminders.where((r) {
      final titleMatch = r.title.toLowerCase().contains(query);
      final noteMatch = r.note.toLowerCase().contains(query);

      return titleMatch || noteMatch;
    }).toList();

    emit(ReminderFiltered(filtered, event.query));
  }
}
