import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/reminder_bloc.dart';
import '../models/reminder.dart';
import 'add_edit_screen.dart';

class ReminderDetailScreen extends StatelessWidget {
  final Reminder reminder;

  const ReminderDetailScreen({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminder Detail"),
        actions: [
          // EDIT BUTTON
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditScreen(reminder: reminder),
                ),
              );
            },
          ),

          // 🔥 DELETE BUTTON IN DETAIL SCREEN
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context
                  .read<ReminderBloc>()
                  .add(DeleteReminder(reminder.id));

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminder.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Time: ${DateFormat.Hm().format(reminder.time)}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            if (reminder.note.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Note:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(reminder.note),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
