import 'package:flutter/material.dart';
import 'package:reminder_app/extensions/string_extension.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/widgets/section_title.dart';

class RecurrenceSelection extends StatelessWidget {
  const RecurrenceSelection({
    super.key,
    required this.recurrence,
    required this.onTap,
  });
  final RecurrenceType recurrence;
  final Function(RecurrenceType value) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: "Recurrence"),
        SizedBox(height: 10),
        Container(
          height: 52,
          width: double.infinity,

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),

          child: DropdownButton<RecurrenceType>(
            value: recurrence,
            isExpanded: true,
            iconEnabledColor: Colors.black,
            dropdownColor: Color(0xffFFFAF1),
            elevation: 1,
            underline: SizedBox.shrink(),
            borderRadius: BorderRadius.circular(12),
            items: RecurrenceType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type.name.capitalize(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              onTap(value!);
            },
          ),
        ),
      ],
    );
  }
}
