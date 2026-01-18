import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../bloc/reminder_bloc.dart';
import '../models/reminder.dart';

class AddEditScreen extends StatefulWidget {
  final Reminder? reminder;

  const AddEditScreen({super.key, this.reminder});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late TextEditingController titleController;
  late TextEditingController noteController;

  DateTime selectedTime = DateTime.now();
  RecurrenceType recurrence = RecurrenceType.none;
  int? selectedWeekday;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.reminder?.title ?? "");

    noteController =
        TextEditingController(text: widget.reminder?.note ?? "");

    if (widget.reminder != null) {
      selectedTime = widget.reminder!.time;
      recurrence = widget.reminder!.recurrence;
      selectedWeekday = widget.reminder!.weekday;
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
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  void save() {
    if (titleController.text.trim().isEmpty) return;

    final reminder = Reminder(
      id: widget.reminder?.id ?? const Uuid().v4(),
      title: titleController.text,
      note: noteController.text,
      time: selectedTime,
      recurrence: recurrence,
      weekday: recurrence == RecurrenceType.weekly
          ? selectedWeekday
          : null,
    );

    if (widget.reminder == null) {
      context.read<ReminderBloc>().add(AddReminder(reminder));
    } else {
      context.read<ReminderBloc>().add(UpdateReminder(reminder));
    }

    Navigator.pop(context);
  }

  Widget buildRecurrenceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recurrence",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<RecurrenceType>(
          initialValue: recurrence,
          items: RecurrenceType.values.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              recurrence = value!;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget buildWeekdaySelector() {
    if (recurrence != RecurrenceType.weekly) {
      return const SizedBox();
    }

    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Select Day",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          initialValue: selectedWeekday,
          items: List.generate(7, (index) {
            return DropdownMenuItem(
              value: index + 1,
              child: Text(days[index]),
            );
          }),
          onChanged: (value) {
            setState(() {
              selectedWeekday = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.reminder != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Reminder" : "New Reminder"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Note",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              icon: const Icon(Icons.access_time),
              label: Text(
                DateFormat.Hm().format(selectedTime),
                style: const TextStyle(fontSize: 16),
              ),
              onPressed: pickTime,
            ),

            const SizedBox(height: 20),

            buildRecurrenceSelector(),

            buildWeekdaySelector(),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Save Reminder",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
