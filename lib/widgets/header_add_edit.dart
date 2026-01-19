import 'package:flutter/material.dart';

class AppHeaderAddEdit extends StatelessWidget {
  const AppHeaderAddEdit({super.key, required this.isEditing});
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: isEditing ? 'Edit ' : 'Add ',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Reminder',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
