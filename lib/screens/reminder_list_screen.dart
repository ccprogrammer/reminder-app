import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reminder_bloc.dart';
import 'add_edit_screen.dart';
import 'package:intl/intl.dart';

class ReminderListScreen extends StatelessWidget {
  const ReminderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReminderBloc>().add(LoadReminders());

    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          if (state is ReminderLoaded) {
            return ListView.builder(
              itemCount: state.reminders.length,
              itemBuilder: (context, index) {
                final r = state.reminders[index];
                return ListTile(
                  title: Text(r.title),
                  subtitle:
                      Text(DateFormat.Hm().format(r.time)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
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
                            AddEditScreen(reminder: r),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
