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
    final isEditing = widget.reminder != null;

    final reminder = Reminder(
      id: isEditing ? widget.reminder!.id : const Uuid().v4(),
      title: titleController.text,
      note: noteController.text,
      time: selectedTime,
      recurrence: recurrence,
    );

    if (isEditing) {
      context.read<ReminderBloc>().add(UpdateReminder(reminder));
    } else {
      context.read<ReminderBloc>().add(AddReminder(reminder));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.reminder != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Reminder" : "Add Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: "Note"),
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: pickTime,
              child: Text(
                "Time: ${DateFormat.Hm().format(selectedTime)}",
              ),
            ),

            const SizedBox(height: 10),

            DropdownButton<RecurrenceType>(
              value: recurrence,
              items: RecurrenceType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  recurrence = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: Text(isEditing ? "Update Reminder" : "Save Reminder"),
            )
          ],
        ),
      ),
    );
  }
}
