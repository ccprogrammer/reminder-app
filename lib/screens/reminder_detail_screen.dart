import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reminder.dart';

class ReminderDetailScreen extends StatelessWidget {
  final Reminder reminder;

  const ReminderDetailScreen({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            Text(
              DateFormat.Hm().format(reminder.time),
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(
              reminder.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            if (reminder.note.isNotEmpty)
              Text(
                reminder.note,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color(0xFF7C3AED),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
