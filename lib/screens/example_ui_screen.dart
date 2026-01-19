import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/widgets/header.dart';
import 'package:reminder_app/widgets/search_bar_widget.dart';
import 'package:reminder_app/widgets/section_title.dart';
import 'package:reminder_app/widgets/tile_wrapper.dart';

class ExampleUIScreen extends StatelessWidget {
  const ExampleUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFAF1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xffFE665C),
        shape: OvalBorder(side: BorderSide(color: Colors.black, width: 1)),
        elevation: 0,
        child: Icon(CupertinoIcons.add, color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHeader(),
                SizedBox(height: 16),
                SearchBarWidget(),

                SizedBox(height: 20),
                SectionTitle(title: "Today's tasks"),
                TileWrapper(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
