import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/bloc/reminder_bloc.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello,",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
        ),
        BlocBuilder<ReminderBloc, ReminderState>(
          builder: (context, state) {
            if (state is ReminderLoaded && state.reminders.isNotEmpty) {
              final reminders = state.reminders;

              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${reminders.length} Tasks ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'today',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'What\'s new ',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'today?',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
