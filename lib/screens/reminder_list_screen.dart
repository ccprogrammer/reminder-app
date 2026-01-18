import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/reminder_bloc.dart';
import '../services/notification_service.dart';
import 'add_edit_screen.dart';
import 'reminder_detail_screen.dart';

class ReminderListScreen extends StatelessWidget {
  const ReminderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReminderBloc>().add(LoadReminders());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: "Test Notification",
            onPressed: () {
              NotificationService.showDummyNotification();
            },
          )
        ],
      ),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          if (state is ReminderLoaded) {
            if (state.reminders.isEmpty) {
              return const Center(
                child: Text("No reminders yet"),
              );
            }

            return ListView.builder(
              itemCount: state.reminders.length,
              itemBuilder: (context, index) {
                final reminder = state.reminders[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(reminder.title),
                    subtitle: Text(
                      DateFormat.Hm().format(reminder.time),
                    ),

                    // 🔥 DELETE BUTTON ON TILE
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context
                            .read<ReminderBloc>()
                            .add(DeleteReminder(reminder.id));
                      },
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ReminderDetailScreen(reminder: reminder),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditScreen(),
            ),
          );
        },
      ),
    );
  }
}
