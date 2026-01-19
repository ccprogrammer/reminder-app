import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 1)
class Reminder extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  String note;

  @HiveField(4)
  RecurrenceType recurrence;

  Reminder({
    required this.id,
    required this.title,
    required this.time,
    required this.note,
    required this.recurrence,
  });
}

@HiveType(typeId: 2)
enum RecurrenceType {
  @HiveField(0)
  none,

  @HiveField(1)
  daily,

  @HiveField(2)
  weekly,

  @HiveField(3)
  monthly,

  @HiveField(4)
  yearly
}
