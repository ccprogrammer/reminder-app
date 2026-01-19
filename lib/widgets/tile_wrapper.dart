import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reminder_bloc.dart';
import '../screens/reminder_detail_screen.dart';
import '../widgets/card_tile.dart';
import '../widgets/section_title.dart';

class TileWrapper extends StatelessWidget {
  const TileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderState>(
      builder: (context, state) {
        final reminders = state is ReminderLoaded
            ? state.reminders
            : state is ReminderFiltered
                ? state.reminders
                : [];

        if (reminders.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const SectionTitle(title: "Today's tasks"),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];

                return CardTile(
                  reminder: reminder,
                  onDeleteTap: () {
                    context
                        .read<ReminderBloc>()
                        .add(DeleteReminder(reminder.id));
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ReminderDetailScreen(reminder: reminder),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
