import 'package:flutter/cupertino.dart';
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
      backgroundColor: Color(0xffFFFAF1),
      appBar: AppBar(
        backgroundColor: Color(0xffFFFAF1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            context.read<ReminderBloc>().add(DeleteReminder(reminder.id));

            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditScreen(reminder: reminder),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<ReminderBloc>().add(DeleteReminder(reminder.id));

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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(CupertinoIcons.time),
                const SizedBox(width: 10),
                Text(
                  DateFormat.Hm().format(reminder.time),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(reminder.note, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
