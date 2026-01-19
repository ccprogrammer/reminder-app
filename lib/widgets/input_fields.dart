import 'package:flutter/material.dart';
import 'package:reminder_app/widgets/section_title.dart';

class InputFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;
  const InputFields({
    super.key,
    required this.titleController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SectionTitle(title: "Task name"),
        const SizedBox(height: 12),
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Color(0xff868686)),
            hintText: "Name",

            filled: true,
            isDense: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
          ),
        ),

        const SizedBox(height: 20),
        SectionTitle(title: "Task note"),
        const SizedBox(height: 12),
        TextField(
          controller: noteController,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Color(0xff868686)),
            hintText: "Note",
            filled: true,
            isDense: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
