import 'package:hive/hive.dart';
import '../models/reminder.dart';

class ReminderRepository {
  static const String boxName = "reminders";

  Future<Box<Reminder>> _openBox() async {
    return await Hive.openBox<Reminder>(boxName);
  }

  Future<List<Reminder>> getReminders() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addReminder(Reminder reminder) async {
    final box = await _openBox();
    await box.put(reminder.id, reminder);
  }

  Future<void> updateReminder(Reminder reminder) async {
    final box = await _openBox();
    await box.put(reminder.id, reminder);
  }

  Future<void> deleteReminder(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
