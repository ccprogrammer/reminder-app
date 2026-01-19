import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:reminder_app/extensions/string_extension.dart';
import 'package:reminder_app/models/reminder.dart';

class CardTile extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;


  const CardTile({
    super.key,
    required this.reminder,
    required this.onTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(top: 16),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black, width: 1),
        ),
      
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    reminder.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: onDeleteTap,
                    child: Icon(
                      CupertinoIcons.delete,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    DateFormat('hh:mm a').format(reminder.time),
                    style: TextStyle(),
                  ),
                  if (reminder.recurrence != RecurrenceType.none)
                    Text(
                      ' - ${reminder.recurrence.name.capitalize()}',
                      style: TextStyle(),
                    ),
                ],
              ),
              SizedBox(height: 10),
              Text(reminder.note, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
