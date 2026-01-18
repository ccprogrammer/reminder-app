import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 1)
enum RecurrenceType {
  @HiveField(0)
  none,

  @HiveField(1)
  daily,

  @HiveField(2)
  weekly,

  @HiveField(3)
  monthly,
}

@HiveType(typeId: 2)
class Reminder extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  // NOW STORES ONLY TIME PART
  @HiveField(2)
  DateTime time;

  @HiveField(3)
  RecurrenceType recurrence;

  @HiveField(4)
  int? recurrenceWeekday;

  @HiveField(5)
  int? recurrenceDayOfMonth;

  Reminder({
    required this.id,
    required this.title,
    required this.time,
    this.recurrence = RecurrenceType.none,
    this.recurrenceWeekday,
    this.recurrenceDayOfMonth,
  });
}
