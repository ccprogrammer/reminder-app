import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reminder_bloc.dart';
import '../models/reminder.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddEditScreen extends StatefulWidget {
  final Reminder? reminder;

  const AddEditScreen({super.key, this.reminder});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late TextEditingController controller;
  late DateTime selectedTime;

  RecurrenceType recurrence = RecurrenceType.none;
  int? weekday;
  int? dayOfMonth;

  @override
  void initState() {
    super.initState();

    controller =
        TextEditingController(text: widget.reminder?.title ?? "");

    selectedTime =
        widget.reminder?.time ?? DateTime.now();

    if (widget.reminder != null) {
      recurrence = widget.reminder!.recurrence;
      weekday = widget.reminder!.recurrenceWeekday;
      dayOfMonth = widget.reminder!.recurrenceDayOfMonth;
    }
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );

    if (time != null) {
      setState(() {
        selectedTime = DateTime(
          2000,
          1,
          1,
          time.hour,
          time.minute,
        );
      });
    }
  }

  void save() {
    final reminder = Reminder(
      id: widget.reminder?.id ?? const Uuid().v4(),
      title: controller.text,
      time: selectedTime,
      recurrence: recurrence,
      recurrenceWeekday: weekday,
      recurrenceDayOfMonth: dayOfMonth,
    );

    if (widget.reminder == null) {
      context.read<ReminderBloc>().add(AddReminder(reminder));
    } else {
      context.read<ReminderBloc>().add(UpdateReminder(reminder));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder == null
            ? "Add Reminder"
            : "Edit Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: pickTime,
              child: Text(
                "Time: ${DateFormat.Hm().format(selectedTime)}",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<RecurrenceType>(
              value: recurrence,
              items: RecurrenceType.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  recurrence = v!;
                });
              },
            ),

            if (recurrence == RecurrenceType.weekly)
              DropdownButton<int>(
                value: weekday,
                hint: const Text("Select Weekday"),
                items: List.generate(
                  7,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text(
                      DateFormat.E()
                          .format(DateTime(2024, 1, i + 1)),
                    ),
                  ),
                ),
                onChanged: (v) {
                  setState(() {
                    weekday = v;
                  });
                },
              ),

            if (recurrence == RecurrenceType.monthly)
              DropdownButton<int>(
                value: dayOfMonth,
                hint: const Text("Day of Month"),
                items: List.generate(
                  28,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text("Day ${i + 1}"),
                  ),
                ),
                onChanged: (v) {
                  setState(() {
                    dayOfMonth = v;
                  });
                },
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
