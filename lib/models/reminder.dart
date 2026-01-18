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

  Reminder({
    required this.id,
    required this.title,
    required this.time,
  });
}
