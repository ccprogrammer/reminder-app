import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/bloc/reminder_bloc.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/screens/reminder_detail_screen.dart';
import 'package:reminder_app/widgets/card_tile.dart';
import 'package:reminder_app/widgets/section_title.dart';

class TileWrapper extends StatelessWidget {
  const TileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderState>(
      builder: (context, state) {
        if (state is ReminderLoaded && state.reminders.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SectionTitle(title: "Today's tasks"),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.reminders.length,
                itemBuilder: (context, index) {
                  final reminder = state.reminders[index];

                  return CardTile(
                    onDeleteTap: () => context.read<ReminderBloc>().add(
                      DeleteReminder(reminder.id),
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
                    reminder: Reminder(
                      id: reminder.id,
                      title: reminder.title,
                      time: reminder.time,
                      note: reminder.note,
                      recurrence: reminder.recurrence,
                    ),
                  );
                },
              ),
            ],
          );
        }

        return Center(child: SizedBox());
      },
    );
  }
}
