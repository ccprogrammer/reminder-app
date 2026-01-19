import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/screens/reminder_detail_screen.dart';
import 'package:reminder_app/widgets/header_add_edit.dart';
import 'package:reminder_app/widgets/input_fields.dart';
import 'package:reminder_app/widgets/recurrence_selection.dart';
import 'package:reminder_app/widgets/save_button.dart';
import 'package:reminder_app/widgets/time_picker.dart';
import 'package:uuid/uuid.dart';

import '../bloc/reminder_bloc.dart';
import '../models/reminder.dart';

class AddEditScreen extends StatefulWidget {
  final Reminder? reminder;

  const AddEditScreen({super.key, this.reminder});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late TextEditingController titleController;
  late TextEditingController noteController;

  DateTime selectedTime = DateTime.now();
  RecurrenceType recurrence = RecurrenceType.none;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.reminder?.title ?? "");

    noteController = TextEditingController(text: widget.reminder?.note ?? "");

    if (widget.reminder != null) {
      selectedTime = widget.reminder!.time;
      recurrence = widget.reminder!.recurrence;
    }
  }

  void save() {
    final isEditing = widget.reminder != null;

    final reminder = Reminder(
      id: isEditing ? widget.reminder!.id : const Uuid().v4(),
      title: titleController.text,
      note: noteController.text,
      time: selectedTime,
      recurrence: recurrence,
    );

    if (isEditing) {
      context.read<ReminderBloc>().add(UpdateReminder(reminder));
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReminderDetailScreen(reminder: reminder),
        ),
      );
    } else {
      context.read<ReminderBloc>().add(AddReminder(reminder));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.reminder != null;

    return Scaffold(
      backgroundColor: Color(0xffFFFAF1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeaderAddEdit(isEditing: isEditing),

              InputFields(
                titleController: titleController,
                noteController: noteController,
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TimePicker(
                      selectedTime: selectedTime,
                      onTap: (time) => setState(() {
                        selectedTime = time;
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RecurrenceSelection(
                      recurrence: recurrence,
                      onTap: (value) {
                        setState(() {
                          recurrence = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Spacer(),
              SaveButton(onTap: save, isEditing: isEditing),
            ],
          ),
        ),
      ),
    );
  }
}
