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
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late TextEditingController controller;
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.reminder?.title ?? "");

    if (widget.reminder != null) {
      selectedTime = widget.reminder!.time;
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
    final reminder = Reminder(
      id: widget.reminder?.id ?? Uuid().v4(),
      title: controller.text,
      time: selectedTime,
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
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: pickTime,
              child: Text(
                "Time: ${DateFormat.Hm().format(selectedTime)}",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
