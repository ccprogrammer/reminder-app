import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/screens/add_edit_screen.dart';
import 'package:reminder_app/widgets/app_header.dart';
import 'package:reminder_app/widgets/search_bar_widget.dart';
import 'package:reminder_app/widgets/tile_wrapper.dart';
import '../bloc/reminder_bloc.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReminderBloc>().add(LoadReminders());

    return Scaffold(
      backgroundColor: Color(0xffFFFAF1),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          children: const [
            AppHeader(),
            SizedBox(height: 16),
            SearchBarWidget(),
            TileWrapper(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEditScreen()),
        ),
        backgroundColor: Color(0xffFE665C),
        shape: OvalBorder(side: BorderSide(color: Colors.black, width: 1)),
        elevation: 0,
        child: Icon(CupertinoIcons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
