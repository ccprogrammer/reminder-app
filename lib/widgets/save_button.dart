import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, this.onTap, this.isEditing = false});
  final VoidCallback? onTap;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffFE665C),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Text(
          isEditing ? "Update Reminder" : "Save Reminder",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
