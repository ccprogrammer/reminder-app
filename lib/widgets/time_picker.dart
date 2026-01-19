// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/widgets/section_title.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    required this.selectedTime,
    required this.onTap,
  });
  final DateTime selectedTime;
  final Function(DateTime time) onTap;

  @override
  Widget build(BuildContext context) {
    Future<void> pickTime() async {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedTime),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xffFE665C),
                onSurface: Colors.black,
              ),
              buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(primary: Color(0xffFE665C)),
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        final pickedTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        );

        onTap(pickedTime);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: "Time"),
        SizedBox(height: 10),
        GestureDetector(
          onTap: pickTime,
          child: Container(
            height: 52,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.time),
                SizedBox(width: 10),
                Text(
                  DateFormat.Hm().format(selectedTime),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
