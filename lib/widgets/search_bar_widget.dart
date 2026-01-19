import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reminder_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<ReminderBloc>().add(SearchReminders(value));
      },
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(color: Color(0xff868686)),
        prefixIcon: const Icon(CupertinoIcons.search, color: Colors.black),
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
      ),
    );
  }
}
