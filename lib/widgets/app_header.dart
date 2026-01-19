import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/bloc/reminder_bloc.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  TextStyle get bold =>
      const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  TextStyle get regular =>
      const TextStyle(fontSize: 32, fontWeight: FontWeight.w500);

  Widget buildRichText(String boldText, String regularText) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: boldText, style: bold),
          TextSpan(text: regularText, style: regular),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello,",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
        ),

        BlocBuilder<ReminderBloc, ReminderState>(
          builder: (context, state) {
            if (state is ReminderLoaded) {
              final count = state.reminders.length;

              if (count > 0) {
                return buildRichText('$count Tasks ', 'today');
              }
            }

            if (state is ReminderFiltered) {
              final count = state.reminders.length;

              if (count == 0) {
                return buildRichText('Task not ', 'found');
              }

              return buildRichText('$count Tasks ', 'today');
            }

            return buildRichText("What's new ", 'today?');
          },
        ),
      ],
    );
  }
}
