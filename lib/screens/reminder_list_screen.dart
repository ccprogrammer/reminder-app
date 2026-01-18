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
              padding: const EdgeInsets.all(16),
              itemCount: state.reminders.length,
              itemBuilder: (context, index) {
                final r = state.reminders[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),

                    title: Text(
                      r.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          DateFormat.Hm().format(r.time),
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (r.note.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              r.note,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        context
                            .read<ReminderBloc>()
                            .add(DeleteReminder(r.id));
                      },
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ReminderDetailScreen(reminder: r),
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
              builder: (_) => AddEditScreen(),
            ),
          );
        },
      ),
    );
  }
}
