import 'package:hive/hive.dart';
import '../models/reminder.dart';

class ReminderRepository {
  static const String boxName = "reminders";

  Future<Box<Reminder>> get box async =>
      await Hive.openBox<Reminder>(boxName);

  Future<List<Reminder>> getReminders() async {
    final b = await box;
    return b.values.toList();
  }

  Future<void> addReminder(Reminder reminder) async {
    final b = await box;
    await b.put(reminder.id, reminder);
  }

  Future<void> updateReminder(Reminder reminder) async {
    final b = await box;
    await b.put(reminder.id, reminder);
  }

  Future<void> deleteReminder(String id) async {
    final b = await box;
    await b.delete(id);
  }
}
